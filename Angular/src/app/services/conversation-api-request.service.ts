import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { Conversation } from '../models/conversation.model';

@Injectable({
  providedIn: 'root'
})
export class ConversationApiRequestService {
  private _currentConversation: Conversation;
  private _currentConversations: Conversation[] = [];

  constructor(private http: HttpClient, private router: Router) {
    this._currentConversation = new Conversation();
  }

  private getUrl(querry: string){
    return '/api/' + querry + '/';
  }

  getConversation(userID: string | null, conversationID: string): Observable<any>{
    return this.http.get<any>(this.getUrl("users/" + userID + "/conversations/" + conversationID)).pipe(
      map(response => {
        if(response){
          console.log("GetConversation: ", response);
          this._currentConversation = response;
          return true;
        }
        else{
          console.log("GetConversation: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error: ', error);
        return of(null);
      })
    )
  }

  getConversationsAdmin(userID: string | null): Observable<any> {
    return this.http.get<any>(this.getUrl("users/" + userID + "/conversations")).pipe(
      map(response => {
        if(response){
          console.log("GetConversationAdmin: ", response);
          this._currentConversations = response;
          return true;
        }
        else{
          console.log("GetConversationAdmin: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error: ', error);
        return of(null);
      })
    )
  }

  sortConversationsAdmin(sortBy: string){

  }

  getCurrentConversation(){
    return this._currentConversation;
  }

  deleteConversation(userID: string | null, conversationId: string): Observable<any> {
    return this.http.delete<any>(this.getUrl("users/" + userID + "/conversations/" + conversationId)).pipe(
      map(response => {
        if (response) {
          console.log("DeleteConversation: ", response)
          return true;
        }
        else {
          console.log("DeleteConversation: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error', error);

        return of(null);
      })
    )
  }

  generateJsonForConversationUpdate(conversation: Conversation) {
    return {
      "conversation": {
        "title": conversation.title,
        "description": conversation.description
      }
    }
  }

  updateCoonversation(userID: string | null, conversationID: string , conversation: Conversation): Observable<any> {
    return this.http.patch(this.getUrl("users/" + userID + "/conversations/" + conversationID), this.generateJsonForConversationUpdate(conversation)).pipe(
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

}
