import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'; 


@Injectable({
  providedIn: 'root'
})
export class ApiRequestService {

  constructor() { }

  private getURL(querry : string ){
    return '/api/'+querry+'/'
  }

}
