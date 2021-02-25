import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { Command } from '../models/command.model';

@Injectable({
  providedIn: 'root'
})
export class CommandApiRequestService {
  private _currenCommand: Command;
  private _currenCommands: Command[] = []

  constructor(private http: HttpClient, private router: Router) {
    this._currenCommand = new Command();
  }

  private getUrl(querry: string) {
    return '/api/' + querry + '/'
  }
  getAllCommandFromOneUser(userID: string | null): Observable<any> {
    return this.http.get<any>(this.getUrl("users/" + userID + "/commands")).pipe(
      map(response => {
        if (response.success) {
          console.log("All Commands : ", response)
          this._currenCommands = response.commands;
          return true;
        }
        else {
          console.log(response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error', error);

        return of(null);
      })
    )
  }
  getOneCommandFromOneUser(userID: string | null, commandId: string): Observable<any> {
    return this.http.get<any>(this.getUrl("users/" + userID + "/commands/" + commandId)).pipe(
      map(response => {
        if (response.success) {
          console.log("Command :", response)
          this._currenCommand = response.command;
          console.log(this._currenCommand);
          return response;
        }
        else {
          console.log(response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error', error);

        return of(null);
      })
    )
  }
  getcurrentCommands(sortBy: string) {
    switch (sortBy) {

      case "lowTotal":
        this._currenCommands.sort((a, b) => Number(a.total) < Number(b.total) ? 1 : -1)
        break;
      case "highTotal":
        this._currenCommands.sort((a, b) => Number(a.total) > Number(b.total) ? 1 : -1);
        break;

      default:
        break;
    }
    console.log(this._currenCommands)
    return this._currenCommands
  }
  getCurrentCommand() {

    return this._currenCommand;
  }
  deleteCommand(commandId: string, userID: string | null): Observable<any> {

    return this.http.delete<any>(this.getUrl("users/" + userID + "/commands/" + commandId)).pipe(
      map(response => {
        if (response) {
          console.log(response)
          return true;
        }
        else {
          console.log(response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error', error);

        return of(null);
      })
    )
  }
  generateJsonForCommandUpdate(command: Command) {
    return {
      "command": {
        "sub_total": command.sub_total,
        "tps": command.tps,
        "tvq": command.tvq,
        "total": command.total,
        "store_pickup": command.store_pickup,
        "state": command.state,
        "shipping_adress": command.shipping_adress
      }
    }
  }
  updateCommand(commandId: string, userID: string | null, command: Command): Observable<any> {
    return this.http.patch(this.getUrl("users/" + userID + "/commands/" + commandId), this.generateJsonForCommandUpdate(command)).pipe(
      map(response => {
        if (response) {
          console.log(response)
          return true;
        }
        else {
          console.log(response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error', error);

        return of(null);
      })
    )
  }
  generateJSONforSearch(querry : string){
    console.log(querry)
    return {
      "q": querry
    }
  }
  createCommand(userID : string){
    return this.http.post<any>(this.getUrl("users/"+ userID+"/commands"),"").pipe(
     map(response =>{
      if(response.success){
        console.log(response)
      }
      
     }),
     catchError(error=> { 
       return of(null)
     })
    )
  }

  searchCommand(querry : string, userID : string ){
    console.log(this.generateJSONforSearch(querry))
    return this.http.get<any>(this.getUrl("users/" + userID + "/commands") + "?q="+querry).pipe(
      map(response => {
        if (response.success) {
          console.log("All Commands : ", response)
          
          this._currenCommands = response.commands;
          return true;
        }
        else {
          console.log(response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error', error);

        return of(null);
      })
    )

  }
}
