import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map, catchError, tap, retry } from 'rxjs/operators';
import { User } from '../models/user.models';
import { Observable, of } from 'rxjs';
@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private readonly CURRENT_USER_KEY = 'jfj.users.currentUser';

  private _currentUser: User | null = null;

  get currentUser(): User | null {
    return this._currentUser;

  }

  get isLoggedIn(): boolean {
    return !!this._currentUser;
  }

  get isAdmin(): boolean {
    return !!this._currentUser?.is_admin;
  }

  constructor(private http: HttpClient) {
    const storedCurrentUser = JSON.parse(sessionStorage.getItem(this.CURRENT_USER_KEY) ?? 'null');

    if (storedCurrentUser) {
      // this._currentUser = new User(storedCurrentUser);

      this._currentUser = storedCurrentUser
      console.log(this.currentUser)
    }
  }
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
    sessionStorage.setItem(this.CURRENT_USER_KEY, JSON.stringify(user));
    console.log(this._currentUser);
  }

  userSignout(): Observable<any> {
    return this.http.delete<any>(this.getUrl("sign_out")).pipe(
      map(response => {
        console.log("New User signout service : ", response);
        if (response?.success) {
          this.setCurrentUser(null);
          return true;
        }
        else {
          return false;
        }
      }),
      catchError(error => {
        console.log('Error', error);

        return of(null);
      })
    )
  }
  userRegistration(newUser: User, picture: File): Observable<any> {
    console.log("UserRegistrationService :", JSON.stringify(newUser));
    const data = new FormData();
    data.append("user", JSON.stringify(newUser));
    data.append("picture", picture)
    console.log('picture:', data.get('picture'));
    return this.http.post<any>('/users.json', data).pipe(
      map(response => {
        console.log("New User service : ", response);
        if (response?.success) {
          console.log("succès:", response);
          this.setCurrentUser(newUser);
          return true;
        }
        else {
          return false;
        }
      }),
      catchError(error => {
        console.log('Error', error);

        return of(null);
      })
    )
  }
  userLogin(email: string, password: string): Observable<any> {
    return this.http.post<any>(this.getUrl("sign_in.json"), this.generateJSONforLogin(email, password)).pipe(
      map(response => {
        if (response?.success) {
          console.log("New User service : ", response);
          console.log("Picture User: ", response.user.picture_url);

          var data = response.user;
          console.log("New User service : ", data);
          let newUser: User = new User();
          newUser = data;
          console.log("New user value ", newUser);

          this.setCurrentUser(newUser);
          return true;
        }
        else {
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
