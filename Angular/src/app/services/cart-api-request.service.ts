import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { Cart } from '../models/cart.model';
import { Product } from '../models/product.model';
import { AuthService } from './auth.services';

@Injectable({
  providedIn: 'root'
})
export class CartApiRequestService {
  private readonly CART_KEY = 'jfj.cart';
  private _cart: Cart | null = null;

  get cart(): Cart | null {
    return this._cart;

  }

  constructor(private http: HttpClient, private authService: AuthService) { }

  private getUrl(querry: string) {
    return '/api/' + querry + '/'
  }

  private generateJSONforCart(product: Product) {//TODO finish it
    return {
      "product": {
        "category": product.category,
        "price": product.price,
        "title": product.title,
        "description": product.description,
        "quantity": product.quantity,
        "animal_type": product.animal_type
      },
      "datatype": "JSON"
    }
  }

  addProductToCart(product: Product): Observable<any> {//TODO finish it
    console.log("add product to cart :", product);
    return this.http.patch<any>(this.getUrl("users/" + this.authService.currentUser?.id + "/carts/" + this.authService.currentUser?.id + ".json"), this.generateJSONforCart(product)).pipe(
      map(response => {
        console.log("add product to cart : ", response);
        if (response?.success) {
          console.log("succès:", response);
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

  showCart(): Observable<any> {
    return this.http.get<any>(this.getUrl("users/" + this.authService.currentUser?.id + "/carts.json")).pipe(
      map(response => {
        if (response.success) {
          console.log("Cart : ", response);
          this._cart = response.cart;
          return response.success;
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
    );
  }
}
