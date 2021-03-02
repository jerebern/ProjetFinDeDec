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
          console.log("response", response);
          console.log("all", localStorage.getItem(this.SEARCH_CART_KEY));
          if (localStorage.getItem(this.SEARCH_CART_KEY) != undefined && localStorage.getItem(this.SEARCH_CART_KEY) != null && localStorage.getItem(this.SEARCH_CART_KEY) != "") {
            response.cart.cartProduct = localStorage.getItem(this.CART_PRODUCT_KEY);
            console.log("Cart test : ", localStorage.getItem(this.CART_PRODUCT_KEY)?.toString());
            let temp = response.cart;
            temp.cartProducts = JSON.parse(localStorage.getItem(this.CART_PRODUCT_KEY)!);
            this._cart = temp;
            localStorage.setItem(this.SEARCH_CART_KEY, "");
          }
          else {
            this._cart = response.cart;
          }
          console.log("Cart : ", this._cart);
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
    localStorage.setItem(this.SORT_KEY, sort);
    this._sort = localStorage.getItem(this.SORT_KEY)!;
    console.log(localStorage.getItem(this.SORT_KEY));
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
          response.cart.cartProducts.forEach((cart_product: { products: string | any[]; }) => {
            if (cart_product.products.length >= 1) {
              cart_products.push(cart_product as CartProduct);
            }
          });
          //localStorage.setItem(this.CART_PRODUCT_KEY, JSON.stringify(cart_products));
          //localStorage.setItem(this.SEARCH_CART_KEY, this._searchCartProduct);

          this._cart!.cartProducts = cart_products;
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
