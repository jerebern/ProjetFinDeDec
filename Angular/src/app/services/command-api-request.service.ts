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


  constructor(private http: HttpClient, private router: Router) {

  }

  private getUrl(id :string) {
    return '/api/commands/' + id
  }
  getAllCommandFromOneUser(sort : string): Observable<any> {
    return this.http.get<any>(this.getUrl("") + "?s="+ sort).pipe(
      map(response => {
        if (response.success) {
          console.log("All Commands : ", response)
          
          return response.commands;
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
  getOneCommandFromOneUser(commandId: string): Observable<any> {
    return this.http.get<any>(this.getUrl( commandId)).pipe(
      map(response => {
        if (response.success) {
          console.log("Command :", response.command)
          // this._currenCommand = response.command;
          // this._currenCommand.command_products = response.command_products
          
          return response.command;
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
  deleteCommand(commandId: string): Observable<any> {
    return this.http.delete<any>(this.getUrl(commandId)).pipe(
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
  updateCommand(commandId: string, command: Command): Observable<any> {
    return this.http.patch(this.getUrl(commandId), this.generateJsonForCommandUpdate(command)).pipe(
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
  generateJSONforTmpController(querry : string){
    console.log(querry)
    return {
      "sendCommand": querry
    }
  }
  createCommand(sendCommand : string){
    return this.http.post<any>(this.getUrl(""),this.generateJSONforTmpController(sendCommand)).pipe(
     map(response =>{
      if(response.success){
       
      }
      
     }),
     catchError(error=> { 
       return of(null)
     })
    )
  }

  searchCommand(querry : string){
    console.log(this.generateJSONforSearch(querry))
    return this.http.get<any>(this.getUrl("") + "?q="+querry).pipe(
      map(response => {
        if (response.success) {
          console.log("All Commands : ", response)
        
          return response.commands;;
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
