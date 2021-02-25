import { Component, Input, OnInit } from '@angular/core';
import { CartProduct } from 'src/app/models/cart-product.model';
import { CartApiRequestService } from 'src/app/services/cart-api-request.service';

@Component({
  selector: '[app-command-items]',
  templateUrl: './command-items.component.html',
  styleUrls: ['./command-items.component.css']
})
export class CommandItemsComponent implements OnInit {
  @Input() cartProduct!: CartProduct;


  constructor(private apiCartService: CartApiRequestService) {

  }

  ngOnInit(): void {


  }


}
