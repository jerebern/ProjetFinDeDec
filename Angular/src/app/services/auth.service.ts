import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map, catchError, tap, retry } from 'rxjs/operators';
import { User } from '../models/user';
@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private currentUser !: User

  constructor(private http: HttpClient) { }

  private getUrl(parameter : string) {
    return "/users/"+parameter
  }
  private generateJSONforLogin(email : string, password : string){
    var newJSON = {
      "email" : email,
      "password" : password
    }
    return newJSON
  }
  userRegistration(newUser: User) {
    console.log("UserRegistrationService :", User)
    return this.http.post<any>(this.getUrl(""), newUser).pipe(
      tap(response => {
        console.log("New User service : ", response);
      })
    )
  }
  userLogin(email : string, password : string) {
    return this.http.post<any>(this.getUrl("sign_in"),this.generateJSONforLogin(email,password)).pipe(
      tap(response => {
        console.log("New User service : ", response);
      })
    )
  }
  getCurrentUser() {
    return this.currentUser;
  }
}
