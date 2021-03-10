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

  private allConversations: Conversation[] = [];
  private allConversationsByUsers : User[] = [];

  constructor(private http: HttpClient, private router: Router, private authService: AuthService) {
  }

  private getUrl(querry: string){
    return '/api/' + querry;
  }

  getOneConversation(conversationID: string): Observable<any>{
    return this.http.get<any>(this.getUrl("conversations/" + conversationID)).pipe(
      map(response =>{
        if(response.success){
          console.log("Conversation(" + conversationID + "): ", response.conversation);
          return response;
        }else{
          console.log("GetOneConversation: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error: ', error);
        return of(null);
      })
    )
  }

  getConversation(): Observable<any>{
    return this.http.get<any>(this.getUrl("conversations")).pipe(
      map(response => {
        if(response.success){
          console.log("GetConversation: ", response);
          return response;
        }
        else{
          console.log("GetConversation false: ", response);
          return false;
        }
      }),
      catchError(error => {
        console.log('Error: ', error);
        return of(null);
      })
    )
  }

  getConversationsAdmin(sort: string): Observable<any>{
      return this.http.get<any>(this.getUrl("conversations/"+"?s="+sort)).pipe(
        map(response => {
          if(response.success){
            console.log("GetConversationAdmin: ", response);

            if(sort == "fullnameUp" || sort == "fullnameDown" || sort == "emailUp" || sort == "emailDown"){
              this.allConversationsByUsers = JSON.parse(response.conversations);
              for(var i = 0; i < this.allConversationsByUsers.length; i++){
                this.allConversations[i] = this.allConversationsByUsers[i].conversation[0];
                this.allConversations[i].fullname = this.allConversationsByUsers[i].fullname;
                this.allConversations[i].user_email = this.allConversationsByUsers[i].email;
              }
            }else{
              this.allConversations = JSON.parse(response.conversations);

              for(var i = 0; i < this.allConversations.length; i++){
                this.allConversations[i].fullname = this.allConversations[i].user.fullname;
                this.allConversations[i].user_email = this.allConversations[i].user.email;
              }
            }
            return this.allConversations;
          }
          else{
            console.log("GetConversationAdmin False: ", response);
            return false;
          }
        }),
        catchError(error => {
          console.log('Error: ', error);
          return of(null);
        })
      )
  }

  createConversation(conversation: Conversation): Observable<any>{
    return this.http.post<any>(this.getUrl("conversations"), conversation).pipe(
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
    return this.http.delete<any>(this.getUrl("conversations/" + conversationId)).pipe(
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
        "description": conversation.description,
        "status": conversation.status
      }
    }
  }

  generateJSONForSearch(querry: string, type: string){
    return{
      "querry":{
        "q": querry,
        "t": type
      }
    }
  }

  updateConversation(conversationID: string, conversation: Conversation): Observable<any>{
    return this.http.patch(this.getUrl("conversations/" + conversationID), this.generateJsonForConversationUpdate(conversation)).pipe(
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
    return this.http.get<any>(this.getUrl("conversations/" + "?q=" + searchParams)).pipe(
      map(response => {
        if(response.success){
          console.log("Search Conversation: ", response.conversations);

          this.allConversations = JSON.parse(response.conversations);
          for(var i = 0; i < this.allConversations.length; i++){
            this.allConversations[i].fullname = this.allConversations[i].user.fullname;
            this.allConversations[i].user_email = this.allConversations[i].user.email;
          }
          return this.allConversations;
        }
        else{
          console.log("Search Conversation: ", response);
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
