import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { CartProduct } from '../models/cart-product.model';
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

  private generateJSONforCart(cartProduct: CartProduct) {//TODO finish it
    return {
      "cart_product": cartProduct,
      "datatype": "JSON"
    }
  }

  addProductToCart(product: Product): Observable<any> {//TODO finish it doesn't work
    console.log("add product to cart :", product);
    return this.http.patch<any>(this.getUrl("users/" + this.authService.currentUser?.id + "/carts/" + this.authService.currentUser?.id + ".json"), "").pipe(
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

  updateCart(cartProduct: CartProduct): Observable<any> {
    console.log('refresh');
    return this.http.patch<any>(this.getUrl("users/" + this.authService.currentUser?.id + "/carts/" + cartProduct.id + ".json"), this.generateJSONforCart(cartProduct)).pipe(
      map(response => {
        if (response.success) {
          console.log("Cart Update: ", response);
          return true;
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

  deleteCartProduct(cartProduct: CartProduct): Observable<any> {
    console.log('refresh');
    return this.http.delete<any>(this.getUrl("users/" + this.authService.currentUser?.id + "/carts/" + cartProduct.id + ".json")).pipe(
      map(response => {
        console.log("CartProduct delete service : ", response.cart_product);
        console.log(response);
        if (response.success) {
          console.log("CartProduct : ", response.cart_product);
          return true;
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
