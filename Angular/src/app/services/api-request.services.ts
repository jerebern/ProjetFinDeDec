import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Product } from '../models/product.model';


@Injectable({
  providedIn: 'root'
})
export class ApiRequestService {

  constructor(private http: HttpClient) { }

  private getURL(querry: string) {
    return '/api/' + querry + '/'
  }

  private setProductsList(products: Product[] | null) {

  }

}
