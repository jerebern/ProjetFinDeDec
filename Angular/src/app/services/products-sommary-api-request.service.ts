import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class ProductsSommaryApiRequestService {

  constructor(private http: HttpClient) { }

  getSommary(searchParams: string): Observable<any> {
    return this.http.get<any>('/api/products_sommaries.json?q=' + searchParams).pipe(
      map(response => {
        if (response.success) {
          return response.products_sommary;
        }
        else {
          console.log(response);
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
