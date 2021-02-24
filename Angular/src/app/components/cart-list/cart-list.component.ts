import { Component, Input, OnInit } from '@angular/core';
import { CartProduct } from 'src/app/models/cart-product.model';
import { Cart } from 'src/app/models/cart.model';

@Component({
  selector: 'app-cart-list',
  templateUrl: './cart-list.component.html',
  styleUrls: ['./cart-list.component.css']
})
export class CartItemsComponent implements OnInit {

  @Input() cart!: Cart;

  constructor() { }

  ngOnInit(): void {
  }

}
