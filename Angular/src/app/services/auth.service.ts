import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'; 
import { User } from '../models/user';
@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor() { }

  private getUrl(querry : string){
    return "/users/"+querry
  }
  userRegistration(newUser : User){
    return this.http.post<any>(this.getUrl("registration"),newUser).pipe(
      
    )
  }
}
