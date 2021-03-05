import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class UserCommandSummariesApiRequestService {

  constructor(private http : HttpClient) { }

  private getUrl(){
    return "/api/products_sommaries"
  }
  
  getSummary(query : string) : Observable<any>{
    return this.http.get<any>(this.getUrl + "?q:"+query).pipe(
      map(response =>{
        return response.user_commands_summary
      })
    )
  }


}
