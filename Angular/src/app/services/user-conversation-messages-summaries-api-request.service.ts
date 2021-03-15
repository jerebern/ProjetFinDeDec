import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class UserConversationMessagesSummariesApiRequestService {

  constructor(private http: HttpClient) { }

  private getUrl(querry: string): string{
    return "/api/user_conversation_messages_summaries/" + querry;
  }

  getSummary(sortMode: string): Observable<any>{
    return this.http.get<any>(this.getUrl("?s=" + sortMode)).pipe(
      map(response => {
        return response.user_conversation_messages_summary;
      })
    )
  }

  searchSummary(searchMode: string): Observable<any>{
    return this.http.get<any>(this.getUrl("?q=" + searchMode)).pipe(
      map(response => {
        return response.user_conversation_messages_summary;
      })
    )
  }

  filterSummary(filerParams: string): Observable<any>{
    return this.http.get<any>(this.getUrl("?f=" + filerParams)).pipe(
      map(response => {
        return response.user_conversation_messages_summary;
      })
    )
  }

}
