import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Product } from 'src/app/models/product.model';
import { AuthService } from 'src/app/services/auth.services';
import { CartApiRequestService } from 'src/app/services/cart-api-request.service';

@Component({
  selector: 'app-products-list-item',
  templateUrl: './products-list-item.component.html',
  styleUrls: ['./products-list-item.component.css']
})
export class ProductsListItemComponent implements OnInit {

  @Input() product!: Product;

  constructor(private authService: AuthService, private apiCartService: CartApiRequestService, private router: Router) { }

  ngOnInit(): void {
  }

  addToCart(product: Product) {
    this.apiCartService.addProductToCart(product, 1).subscribe(success => {
      if (success) {
        console.log("OK");
        alert("Ajouter au Panier : " + success + " produit(s)");
      }
      else {
        console.log("ERROR", success);
        alert("ERROR!!!");
      }
    });
  }

  login() {
    this.router.navigate(['/login']);
  }

  isLoggedIn(): boolean {
    return this.authService.isLoggedIn;
  }

}
