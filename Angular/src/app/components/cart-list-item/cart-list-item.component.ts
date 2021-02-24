import { Component, Input, OnInit } from '@angular/core';
import { CartProduct } from 'src/app/models/cart-product.model';
import { Cart } from 'src/app/models/cart.model';

@Component({
  selector: '[app-cart-list-item]',
  templateUrl: './cart-list-item.component.html',
  styleUrls: ['./cart-list-item.component.css']
})
export class CartListItemComponent implements OnInit {

  @Input() cartProduct!: CartProduct;

  constructor() {
  }

  ngOnInit(): void {
    console.log(this.cartProduct);
  }

}
