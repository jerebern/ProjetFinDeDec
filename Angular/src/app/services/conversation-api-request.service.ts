import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { Conversation } from '../models/conversation.model';
import { User } from '../models/user.models';
import { AuthService } from './auth.services';

@Injectable({
  providedIn: 'root'
})
export class ConversationApiRequestService {

  private readonly CURRENT_CONVERSATION_KEY = 'jfj.currentConversation';

  private _currentConversation: Conversation;;
  private allConversations: Conversation[] = [];
  private conversation: Conversation | null = null;

  get currentConversation(){
    return this._currentConversation;
  }

  constructor(private http: HttpClient, private router: Router, private authService: AuthService) {
    this._currentConversation = new Conversation();

    const storedCurrentConversation = JSON.parse(localStorage.getItem(this.CURRENT_CONVERSATION_KEY) ?? 'null');

    if (storedCurrentConversation) {
      this._currentConversation = storedCurrentConversation
      console.log(this.currentConversation)
    }
  }

  private getUrl(querry: string){
    return '/api/' + querry + '/';
  }

  getConversation(userID: string | null, conversationID: string): Observable<any>{
    return this.http.get<any>(this.getUrl("users/" + userID + "/conversations/" + conversationID)).pipe(
      map(response => {
        if(response){
          console.log("GetConversation: ", response);
          this._currentConversation = response[0];
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

  getConversationsAdmin(userID: string | null){
      return this.http.get<any>(this.getUrl("users/" + userID + "/conversations")).pipe(
        map(response => {
          if(response){
            console.log("GetConversationAdmin: ", response);
            this.allConversations = response;
            console.log("AllConversations: ", this.allConversations);

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

  setCurrentConversation(conversation: Conversation){
    this._currentConversation = conversation;
    localStorage.setItem(this.CURRENT_CONVERSATION_KEY, JSON.stringify(conversation));
    console.log("SetCurrentConversation: ", this._currentConversation)
  }

  sortConversationsAdmin(sortBy: string){

  }

  createConversation(userID: string | null, conversation: Conversation): Observable<any>{
    return this.http.post<any>(this.getUrl("users/" + userID + "/conversations"), conversation).pipe(
      map(response => {
        if(response){
          console.log("CreateConversation: ", response);
          return true;
        }
        else{
          console.log("CreateConversation: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log("Error: ", error);
        return of(null);
      })
    )
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
        console.log('Error: ', error);

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

  updateConversation(userID: string | null, conversationID: string , conversation: Conversation): Observable<any> {
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
        console.log('Error: ', error);

        return of(null);
      })
    )
  }

  getConversations(){
    return this.allConversations;
  }
}
