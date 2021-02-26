import { stringify } from '@angular/compiler/src/util';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { CartProduct } from 'src/app/models/cart-product.model';
import { Cart } from 'src/app/models/cart.model';
import { CartApiRequestService } from 'src/app/services/cart-api-request.service';
import { JSONObject } from 'ts-json-object';
import { __createBinding } from 'tslib';

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit {

  private _cart!: Cart;

  cartForm: FormGroup;
  searchCartProductForm: FormGroup;

  get cart() {
    return this._cart;
  }

  constructor(private apiCartService: CartApiRequestService) {
    this.apiCartService.showCart().subscribe(success => {
      if (success) {
        console.log("OK", this.apiCartService.cart);
        if (this.apiCartService.sort == "CTotal") {
          this.apiCartService.cart?.cartProducts.sort((a, b) => Number(a.total_price) > Number(b.total_price) ? 1 : -1)
        }
        else if (this.apiCartService.sort == "DTotal") {
          this.apiCartService.cart?.cartProducts.sort((a, b) => Number(a.total_price) < Number(b.total_price) ? 1 : -1)
        }
        else if (this.apiCartService.sort == "CPrix") {
          this.apiCartService.cart?.cartProducts.sort((a, b) => Number(a.products[0].price) > Number(b.products[0].price) ? 1 : -1)
        }
        else if (this.apiCartService.sort == "DPrix") {
          this.apiCartService.cart?.cartProducts.sort((a, b) => Number(a.products[0].price) < Number(b.products[0].price) ? 1 : -1)
        }
        console.log(this.apiCartService.sort);
        this._cart = this.apiCartService.cart!;
      }
      else {
        console.log("ERROR", success);
        alert("ERROR!!!");
      }
    });
    this.cartForm = new FormGroup({
      shipping: new FormControl('0'),
    });
    this.searchCartProductForm = new FormGroup({
      search: new FormControl('')
    })
  }

  ngOnInit(): void {
  }

  checkUp() {///fonction pour passer aux commandes
    let shipping = this.cartForm.get('shipping')?.value;
    console.log(shipping);
    this.apiCartService.showCart().subscribe(success => {
      if (success) {
        console.log("OK", this.apiCartService.cart);
        this._cart = this.apiCartService.cart!;
        let cartProducts = this._cart.cartProducts;

        /////code de Jé Bernard

      }
      else {
        console.log("ERROR", success);
        alert("ERROR!!!");
      }
    });
  }

  searchCartProduct() {
    let querry = this.searchCartProductForm.get('search')?.value
    console.log(querry)
    this.apiCartService.searchCartProduct(querry).subscribe(success => {
      if (success) {
        console.log("OK");
        window.location.reload();
      }
      else {
        console.log("ERROR", success);
        alert("ERROR!!!");
      }
    });
  }
}
