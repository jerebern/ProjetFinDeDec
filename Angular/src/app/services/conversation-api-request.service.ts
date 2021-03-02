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

  getConversation(): Observable<any>{
    return this.http.get<any>(this.getUrl("/conversations")).pipe(
      map(response => {
        if(response.success){
          console.log("GetConversation: ", response);
          this._currentConversation = response.conversation[0];
          console.log("CurrentConversation: ", this._currentConversation);
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

  getConversationsAdmin(): Observable<any>{
      return this.http.get<any>(this.getUrl("/conversations")).pipe(
        map(response => {
          if(response.success){
            console.log("GetConversationAdmin: ", response);
            this.allConversations = response.conversations;
            for(var i = 0; i < this.allConversations.length; i++){
              this.allConversations[i].user_email = response.emails[i];
            }
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

  createConversation(conversation: Conversation): Observable<any>{
    return this.http.post<any>(this.getUrl("/conversations"), conversation).pipe(
      map(response => {
        if(response.success){
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

  deleteConversation(conversationId: string): Observable<any>{
    return this.http.delete<any>(this.getUrl("/conversations/" + conversationId)).pipe(
      map(response => {
        if (response.success) {
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

  generateJSONForSearch(querry: string){
    return{
      "q": querry
    }
  }

  updateConversation(conversationID: string, conversation: Conversation): Observable<any>{
    return this.http.patch(this.getUrl("/conversations/" + conversationID), this.generateJsonForConversationUpdate(conversation)).pipe(
      map(response => {
        if (response) {
          console.log("Update Conversation: ", response)
          return true;
        }
        else {
          console.log("Update Conversation: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error: ', error);

        return of(null);
      })
    )
  }

  searchConversation(searchParams: string): Observable<any>{
    console.log("SearchParamsConversation: ", this.generateJSONForSearch(searchParams));
    return this.http.get<any>(this.getUrl("/conversations") + "?q=" + searchParams).pipe(
      map(response => {
        if(response.success){
          console.log("Search Conversaion: ", response.conversations);

        }
      })
    )
  }

  getConversations(){
    return this.allConversations;
  }
}
