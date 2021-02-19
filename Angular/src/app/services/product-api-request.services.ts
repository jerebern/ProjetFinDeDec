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
  get products(): Product[] {
    let Products: Product[] = [];
    const storedProducts = JSON.parse(localStorage.getItem(this.PRODUCTS_KEY) ?? 'null');

    if (storedProducts) {
      Products = storedProducts as Product[];
    }
    //console.log("storedProducts:", storedProducts, "Products:", Products)
    return Products;
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
      }
    }
  }

  listProducts(): Observable<any> {
    return this.http.get<any>(this.getUrl("products.json")).pipe(
      map(response => {
        if (response) {
          console.log("Products list : ", response);
          localStorage.setItem(this.PRODUCTS_KEY, JSON.stringify(response));
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
        if (response) {
          console.log("Product : ", response);
          return response;
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
        if (response) {
          console.log("Product : ", response);
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
        if (response) {
          console.log("Product : ", response);
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

  addProductToCart(product: Product, quantity: number) {
    product.quantity = (Number(product.quantity) - quantity).toString();
    console.log(product, quantity);
    this.updateProduct(product).subscribe(success => {
      if (success) {
        console.log("OK", success)
      }
      else {
        console.log("ERROR")
        alert("ERROR!!!");
        window.location.reload();
      }
    });////for now addProductToCart just update the product.quantity by removing 1 in quantity
  }

  deleteProductFromStore(product: Product) {
    console.log("produit à supprimer: ", product);
    this.deleteProduct(product).subscribe(success => {
      if (success) {
        console.log("OK", success)
        this.listProducts().subscribe(success => {
          if (success) {
            console.log("OK")
            this.router.navigate(['/products']);
          }
          else {
            console.log("ERROR")
            alert("ERROR!!!");
          }
        });
      }
      else {
        console.log("ERROR")
        alert("ERROR!!!");
      }
    });
  }

  searchProduct(searchParams: string) {
    this.listProducts().subscribe(success => {
      var index = (typeof this.products !== 'undefined') ? this.products.filter((element) => {
        return element.animal_type.includes(searchParams) || element.category.includes(searchParams) || element.title.includes(searchParams) || element.description.includes(searchParams);
      }) : true;
      localStorage.setItem(this.PRODUCTS_KEY, JSON.stringify(index));
    });
  }

  filterProducts(animal: string, category: string, sortBy: number) {
    this.listProducts().subscribe(success => {
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
        localStorage.setItem(this.PRODUCTS_KEY, JSON.stringify(index));
      }
      else {
        console.log("ERROR")
        alert("ERROR!!!");
      }
    });
  }

}
