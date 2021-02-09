import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'; 
import { map, catchError, tap } from 'rxjs/operators';
import { User } from '../models/user';
@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient) { }

  private getUrl(querry : string){
    return "/users/"+querry
  }
  userRegistration(newUser : User){
    return this.http.post<any>(this.getUrl("registration"),newUser).pipe(
      tap(response =>{
        console.log("New User service : ", response);
      })
    )
  }
}
