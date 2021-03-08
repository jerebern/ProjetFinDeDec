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
  private readonly CART_PRODUCT_KEY = 'jfj.cart_product'
  private readonly SEARCH_CART_KEY = 'jfj.cart_product.search'
  private _searchCartProduct: string | null = null;
  get searchParams(): string | null {
    return this._searchCartProduct;
  }
  private _cart: Cart | null = null;
  private _sort: string = "CTotal"

  get cart(): Cart | null {
    return this._cart;
  }
  get sort(): string | null {
    return this._sort;
  }

  constructor(private http: HttpClient, private authService: AuthService) {
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
    let newProduct: Product = product;
    cartProduct.product = newProduct;
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
          console.log("response", response);
          this._cart = response.cart;
          console.log("Cart : ", this.cart);
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
    console.log(sort);
    this._sort = sort;
  }

  generateJSONforSearch(querry: string) {
    console.log(querry)
    return {
      "q": querry
    }
  }

  searchCartProduct(searchParams: string) {
    console.log(this.generateJSONforSearch(searchParams))
    return this.http.get<any>(this.getUrl("users/" + this.authService.currentUser?.id + "/carts.json") + "?q=" + searchParams).pipe(
      map(response => {
        if (response.success) {
          console.log("Search Cart Products : ", response);
          this._searchCartProduct = searchParams;
          let cart_products: CartProduct[] = [];
          response.cart.cart_products.forEach((cart_product: { product: string | any; }) => {
            if (cart_product.product != null) {
              console.log(cart_product as CartProduct)
              cart_products.push(cart_product as CartProduct);
            }
          });
          this._cart!.cart_products = cart_products;
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
