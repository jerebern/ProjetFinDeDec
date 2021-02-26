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
  private readonly SORT_KEY = 'jfj.sort';
  private _cart: Cart | null = null;
  private _sort: string = "CTotal"

  get cart(): Cart | null {
    return this._cart;
  }
  get sort(): string | null {
    return this._sort;
  }

  constructor(private http: HttpClient, private authService: AuthService) {
    if (localStorage.getItem(this.SORT_KEY)) {
      this._sort = localStorage.getItem(this.SORT_KEY)!?.toString();
    }
    else {
      localStorage.setItem(this.SORT_KEY, this._sort);
    }
  }

  private getUrl(querry: string) {
    return '/api/' + querry + '/'
  }

  private generateJSONforCartProduct(cartProduct: CartProduct) {
    return {
      "cart_product": cartProduct,
      "datatype": "JSON"
    }
  }

  addProductToCart(product: Product, quantity: number): Observable<any> {
    let cartProduct = new CartProduct();
    let newProduct: Product[] = [product];
    cartProduct.products = newProduct;
    cartProduct.quantity = quantity.toString();
    console.log("add product to cart :", cartProduct);
    return this.http.post<any>(this.getUrl("users/" + this.authService.currentUser?.id + "/carts.json"), this.generateJSONforCartProduct(cartProduct)).pipe(
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
    return this.http.patch<any>(this.getUrl("users/" + this.authService.currentUser?.id + "/carts/" + cartProduct.id + ".json"), this.generateJSONforCartProduct(cartProduct)).pipe(
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

  setSort(sort: string) {
    localStorage.setItem(this.SORT_KEY, sort);
  }
}
