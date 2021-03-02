import { Component, Input, OnInit } from '@angular/core';
import { CartProduct } from 'src/app/models/cart-product.model';
import { Cart } from 'src/app/models/cart.model';
import { CartApiRequestService } from 'src/app/services/cart-api-request.service';
import { CartComponent } from '../cart/cart.component';

@Component({
  selector: 'app-cart-list',
  templateUrl: './cart-list.component.html',
  styleUrls: ['./cart-list.component.css']
})
export class CartItemsComponent implements OnInit {

  @Input() cart!: Cart;

  constructor(private apiCartService: CartApiRequestService, private cartComponent: CartComponent) { }

  ngOnInit(): void {
  }

  sortBy(sortMode: string) {
    switch (sortMode) {
      case "Total":
        if (this.apiCartService.sort == "CTotal") {
          this.apiCartService.setSort("DTotal");
        }
        else if (this.apiCartService.sort == "DTotal") {
          this.apiCartService.setSort("CTotal");
        }
        else {
          this.apiCartService.setSort("CTotal");
        }
        break;
      case "Prix":
        if (this.apiCartService.sort == "CPrix") {
          this.apiCartService.setSort("DPrix");
        }
        else if (this.apiCartService.sort == "DPrix") {
          this.apiCartService.setSort("CPrix");
        }
        else {
          this.apiCartService.setSort("CPrix");
        }
        break;
    }
    this.apiCartService.showCart().subscribe(success => {
      if (success) {
        console.log("OK", this.apiCartService.sort);
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
        //window.location.reload();
        this.cart = this.apiCartService.cart!;
        this.cartComponent.reset();
      }
      else {
        console.log("ERROR", success);
        alert("ERROR!!!");
      }
    });
  }

}
