import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { of } from 'rxjs';
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
    return '/api/' + querry + '/';
  }

  getAllMessages(userID: string | undefined){
    return this.http.get<any>(this.getUrl("users/" + userID + "/messages")).pipe(
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

  createMessage(userID: string | undefined, message: Message){
    return this.http.post<any>(this.getUrl("users/" + userID + "/messages"), message).pipe(
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

}
