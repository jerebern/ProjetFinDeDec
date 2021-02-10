import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map, catchError, tap } from 'rxjs/operators';
import { User } from '../models/user';
@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private currentUser !: User

  constructor(private http: HttpClient) { }

  private getUrl(querry: string) {
    return "/users/"
  }
  userRegistration(newUser: User) {
    console.log("UserRegistrationService :", User)
    return this.http.post<any>(this.getUrl("sign_up"), newUser).pipe(
      tap(response => {
        console.log("New User service : ", response);
      })
    )
  }
  userLogin() {

  }
  getCurrentUser() {
    return this.currentUser;
  }
}
