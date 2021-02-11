import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map, catchError, tap, retry } from 'rxjs/operators';
import { User } from '../models/user';
@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private _currentUser: User | null = null;

  get currentUser(): User | null {
    return this._currentUser;
  }

  get isLoggedIn(): boolean {
    return !!this._currentUser;
  }

  constructor(private http: HttpClient) { }

  private getUrl(parameter: string) {
    return "/users/" + parameter
  }
  private generateJSONforLogin(email: string, password: string) {
    return {
      "user": {
        "email": email,
        "password": password
      }
    }
  }

  private setCurrentUser(user: User | null) {
    this._currentUser = user;
    console.log(this._currentUser);
  }

  userSignout() {
    return this.http.delete<any>(this.getUrl("sign_out")).pipe(
      tap(response => {
        console.log("New User signout service : ", response);
        this.setCurrentUser(null);
      })
    )
  }
  userRegistration(newUser: User) {
    console.log("UserRegistrationService :", User)
    return this.http.post<any>(this.getUrl(""), newUser).pipe(
      tap(response => {
        console.log("New User service : ", response);
      })
    )
  }
  userLogin(email: string, password: string) {
    return this.http.post<any>(this.getUrl("sign_in.json"), this.generateJSONforLogin(email, password)).pipe(
      tap(response => {
        console.log("New User service : ", response);
        var data = response.user;
        console.log("New User service : ", data);
        let newUser: User = new User();
        newUser.email = data.email;
        newUser.password = data.password;
        newUser.firstname = data.firstname
        newUser.lastname = data.lastname
        newUser.address = data.address
        newUser.city = data.city
        newUser.postal_code = data.postal_code
        newUser.province = data.province
        newUser.phone_number = data.phone_number
        console.log("New user value ", newUser);
        this.setCurrentUser(newUser);
      })
    )
  }
  getCurrentUser() {
    return this._currentUser;
  }
}
