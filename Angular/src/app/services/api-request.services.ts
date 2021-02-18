import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Product } from '../models/product.model';
import { tap } from 'rxjs/operators';
import { User } from '../models/user.models';
import { Command } from '../models/command.model';


@Injectable({
  providedIn: 'root'
})
export class ApiRequestService {
  private readonly PRODUCTS_KEY = 'jfj.products';
  private _currenCommand !: Command;
  get products(): Product[] {
    let Products: Product[] = [];
    const storedProducts = JSON.parse(localStorage.getItem(this.PRODUCTS_KEY) ?? 'null');

    if (storedProducts) {
      Products = storedProducts as Product[];
    }
    //console.log("storedProducts:", storedProducts, "Products:", Products)
    return Products;
  }

  constructor(private http: HttpClient) {
    ///////
  }

  private getUrl(querry: string) {
    return '/api/' + querry + '/'
  }

  listProducts() {
    return this.http.get<any>(this.getUrl("products.json")).pipe(
      tap(response => {
        console.log("Products list : ", response);
        localStorage.setItem(this.PRODUCTS_KEY, JSON.stringify(response));
      })
    )
  }

  showProduct(id: number) {
    return this.http.get<any>(this.getUrl("products/" + id + ".json")).pipe(
      tap(response => {
        console.log("Product : ", response);
      })
    )
  }
  getAllCommandFromOneUser(userID: string | null) {
    return this.http.get<any>(this.getUrl("users/" + userID + "/commands")).pipe(
      tap(response => {
        console.log("All Commands : ", response)
      })
    )
  }
  getOneCommandFromOneUser(userID: string | null, commandId: string) {
    console.log("le fucking user id me fait chier ", userID)
    return this.http.get<any>(this.getUrl("users/" + userID + "/commands/" + commandId)).pipe(
      tap(response => {
        console.log("Command :", response)
        this._currenCommand = response;
        console.log(this._currenCommand);

      })
    )
  }
  getCurrentCommand() {
    return this._currenCommand;
  }

  filterProducts(animal: string, category: string) {
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
        localStorage.setItem(this.PRODUCTS_KEY, JSON.stringify(index));
      }
      else {
        console.log("ERROR")
        alert("ERROR!!!");
      }
    });
  }

}
