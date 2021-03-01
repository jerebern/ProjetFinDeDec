import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Product } from 'src/app/models/product.model';
import { AuthService } from 'src/app/services/auth.services';
import { CartApiRequestService } from 'src/app/services/cart-api-request.service';
import { ProductApiRequestService } from 'src/app/services/product-api-request.services';

@Component({
  selector: 'app-welcome',
  templateUrl: './welcome.component.html',
  styleUrls: ['./welcome.component.css']
})
export class WelcomeComponent implements OnInit {

  get product1(): Product {
    return this.products.find(s => s.id === 7)!;
  }
  get product2(): Product {
    return this.products.find(s => s.id === 2)!;
  }
  get product3(): Product {
    return this.products.find(s => s.id === 3)!;
  }
  get product4(): Product {
    return this.products.find(s => s.id === 4)!;
  }
  get product5(): Product {
    return this.products.find(s => s.id === 8)!;
  }
  get product6(): Product {
    return this.products.find(s => s.id === 5)!;
  }

  get products(): Product[] {
    return this.apiService.products;
  }

  constructor(private authService: AuthService, private apiService: ProductApiRequestService, private apiCartService: CartApiRequestService, private router: Router) {
    //console.log(this.products.findIndex(s => s.id === 1), this.products.find(s => s.id === 1));
    this.apiService.listProducts().subscribe(success => {
      if (success) {
        console.log("OK");
      }
      else {
        console.log("ERROR", success);
        alert("ERROR!!!");
      }
    });
  }

  ngOnInit(): void {

  }

  addToCart(product: Product) {
    if (this.isLoggedIn() == true) {
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
    else if (this.isLoggedIn() == false) {
      this.login();
    }
  }

  goTo(id: number) {
    this.router.navigate(['/products/' + id]);
  }

  login() {
    this.router.navigate(['/login']);
  }

  isLoggedIn(): boolean {
    return this.authService.isLoggedIn;
  }
}
