import { Component, Input, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { CartProduct } from 'src/app/models/cart-product.model';
import { Cart } from 'src/app/models/cart.model';
import { CartApiRequestService } from 'src/app/services/cart-api-request.service';

@Component({
  selector: '[app-cart-list-item]',
  templateUrl: './cart-list-item.component.html',
  styleUrls: ['./cart-list-item.component.css']
})
export class CartListItemComponent implements OnInit {

  @Input() cartProduct!: CartProduct;

  cartItemForm: FormGroup;

  constructor(private apiCartService: CartApiRequestService) {
    this.cartItemForm = new FormGroup({
      quantity: new FormControl(''),
    });
  }

  ngOnInit(): void {
    console.log(this.cartProduct);
    this.cartItemForm.get('quantity')?.setValue(this.cartProduct.quantity);
  }

  refreshItem() {
    this.cartProduct.quantity = this.cartItemForm.get('quantity')?.value;
    this.apiCartService.updateCart(this.cartProduct).subscribe(success => {
      if (success) {
        console.log("OK", this.apiCartService.cart);
      }
      else {
        console.log("ERROR", success);
        alert("ERROR!!!");
      }
    });
  }

}
