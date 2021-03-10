import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Product } from '../models/product.model';
import { catchError, map } from 'rxjs/operators';
import { User } from '../models/user.models';
import { Command } from '../models/command.model';
import { Router } from '@angular/router';
import { Observable, of } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
export class ProductApiRequestService {
  private readonly PRODUCTS_KEY = 'jfj.products';
  private _searchProduct: string = "";
  private _products: Product[] = [];
  get searchParams(): string {
    return this._searchProduct;
  }
  get products(): Product[] {
    return this._products;
  }

  constructor(private http: HttpClient, private router: Router) {
    ///////
  }

  private getUrl(querry: string) {
    return '/api/' + querry + '/'
  }

  private generateJSONforProduct(product: Product) {
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

  listProducts(): Observable<any> {
    return this.http.get<any>(this.getUrl("products.json")).pipe(
      map(response => {
        if (response.success) {
          console.log("Products list : ", response.products);
          this._products = response.products
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

  searchProducts(searchParams: string): Observable<any> {
    console.log(this.generateJSONforSearch(searchParams))
    return this.http.get<any>(this.getUrl("/products") + "?q=" + searchParams).pipe(
      map(response => {
        if (response.success) {
          console.log("Search Products : ", response.products)
          this._searchProduct = searchParams;
          this._products = response.products
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

  showProduct(id: number): Observable<any> {
    return this.http.get<any>(this.getUrl("products/" + id + ".json")).pipe(
      map(response => {
        if (response.success) {
          console.log("Product : ", response.product);
          return response.product;
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

  updateProduct(product: Product): Observable<any> {
    return this.http.patch<any>(this.getUrl("products/" + product.id + ".json"), this.generateJSONforProduct(product)).pipe(
      map(response => {
        if (response.success) {
          console.log("Product Update: ", response.product);
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

  deleteProduct(product: Product): Observable<any> {
    return this.http.delete<any>(this.getUrl("products/" + product.id + ".json")).pipe(
      map(response => {
        console.log("Product delete service : ", response.product);
        if (response.success) {
          console.log("Product : ", response.product);
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

  // addProductToCart(product: Product, quantity: number) {
  //   product.quantity = (Number(product.quantity) - quantity).toString();
  //   console.log(product, quantity);
  //   this.updateProduct(product).subscribe(success => {
  //     if (success) {
  //       console.log("OK", success)
  //     }
  //     else {
  //       console.log("ERROR")
  //       alert("ERROR!!!");
  //       window.location.reload();
  //     }
  //   });////for now addProductToCart just update the product.quantity by removing 1 in quantity proof for update product
  // }

  generateJSONforSearch(querry: string) {
    console.log(querry)
    return {
      "q": querry
    }
  }
  ///TODO: changer ça et le déplacer dans products.component.ts
  filterProducts(animal: string, category: string, sortBy: number) {
    this.searchProducts(this.searchParams).subscribe(success => {
      if (success) {
        console.log("OK")
        var index;
        if (category == "Toutes les Catégories" && animal == "Tous les Animaux") {
          index = this.products;
          console.log('1', index);
        }
        else if (animal == "Tous les Animaux") {
          index = this.products.filter(s => s.category === category);
          console.log('2', index);
        }
        else if (category == "Toutes les Catégories") {
          index = this.products.filter(s => s.animal_type === animal);
          console.log('3', index);
        }
        else {
          index = this.products.filter(s => s.animal_type === animal).filter(s => s.category === category);
          console.log('4', index);
        }
        if (sortBy == 1) {
          index.sort((a, b) => a.title > b.title ? 1 : -1);
        }
        else if (sortBy == 2) {
          index.sort((a, b) => a.title < b.title ? 1 : -1);
        }
        else if (sortBy == 3) {
          index.sort((a, b) => Number(a.price) > Number(b.price) ? 1 : -1);
        }
        else if (sortBy == 4) {
          index.sort((a, b) => Number(a.price) < Number(b.price) ? 1 : -1);
        }
        this._products = index;
      }
      else {
        console.log("ERROR")
        alert("ERROR!!!");
      }
    });
  }

}
