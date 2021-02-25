import { Component, Input, OnInit } from '@angular/core';
import { Product } from 'src/app/models/product.model';
import { CartApiRequestService } from 'src/app/services/cart-api-request.service';

@Component({
  selector: 'app-products-list-item',
  templateUrl: './products-list-item.component.html',
  styleUrls: ['./products-list-item.component.css']
})
export class ProductsListItemComponent implements OnInit {

  @Input() product!: Product;

  constructor(private apiCartService: CartApiRequestService) { }

  ngOnInit(): void {
  }

  addToCart(product: Product) {
    this.apiCartService.addProductToCart(product, 1).subscribe(success => {
      if (success) {
        console.log("OK");
      }
      else {
        console.log("ERROR", success);
        alert("ERROR!!!");
      }
    });
  }

}
