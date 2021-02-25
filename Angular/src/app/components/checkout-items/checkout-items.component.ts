import { Component, Input, OnInit } from '@angular/core';
import { CartProduct } from 'src/app/models/cart-product.model';
import { CartApiRequestService } from 'src/app/services/cart-api-request.service';

@Component({
  selector: '[app-checkout-items]',
  templateUrl: './checkout-items.component.html',
  styleUrls: ['./checkout-items.component.css']
})
export class CheckoutItemsComponent implements OnInit {
  @Input() cartProduct!: CartProduct;


  constructor(private apiCartService: CartApiRequestService) {

  }

  ngOnInit(): void {


  }


}
