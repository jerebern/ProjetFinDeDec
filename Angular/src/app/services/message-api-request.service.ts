import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { Message } from 'src/app/models/message.model';
import { AuthService } from './auth.services';

@Injectable({
  providedIn: 'root'
})
export class MessageApiRequestService {

  private _currentMessage: Message;
  private allMessages: Message[] = [];

  constructor(private http: HttpClient, private authService: AuthService) {
    this._currentMessage = new Message();
  }

  private getUrl(querry: string){
    return '/api/' + querry;
  }

  getAllMessages(): Observable<any>{
    return this.http.get<any>(this.getUrl("messages")).pipe(
      map(response => {
        if(response.success){
          console.log("GetAllMessages: ", response);
          this.allMessages = response.messages;
          return true;
        }else{
          console.log("GetAllMessages: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error: ', error);
        return of(null);
      })
    )
  }

  getMessages(){
    return this.allMessages;
  }

  createMessage(message: Message): Observable<any>{
    return this.http.post<any>(this.getUrl("messages"), message).pipe(
      map(response => {
        if(response.success){
          console.log("CreateMessage: ", response);
          return true;
        }
        else{
          return false;
        }
      }),
      catchError(error => {
        console.log("Error: ", error);
        return of(null);
      })
    )
  }

  deleteMessage(messageID: string): Observable<any>{
    return this.http.delete<any>(this.getUrl("messages/" + messageID)).pipe(
      map(response => {
        if (response.success) {
          console.log("DeleteMessage: ", response)
          return true;
        }
        else {
          console.log("DeleteMessage: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error: ', error);

        return of(null);
      })
    )
  }

  generateJsonForMessageUpdate(message: Message) {
    return {
      "message": {
        "body": message.body
      }
    }
  }

  updateMessage(messageID: string, message: Message): Observable<any>{
    return this.http.patch(this.getUrl("messages/" + messageID), this.generateJsonForMessageUpdate(message)).pipe(
      map(response => {
        if (response) {
          console.log("Update Message: ", response)
          return true;
        }
        else {
          console.log("Update Message: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error: ', error);

        return of(null);
      })
    )
  }

  searchMessages(searchParams: string): Observable<any>{
    return this.http.get<any>(this.getUrl("messages/" + "?q=" + searchParams)).pipe(
      map(response => {
        if(response.success){
          console.log("Search Messages: ", response);
          this.allMessages = response.messages;
          return true;
        }else{
          console.log("Search Messages: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error: ', error);
        return of(null);
      })
    )
  }


}
