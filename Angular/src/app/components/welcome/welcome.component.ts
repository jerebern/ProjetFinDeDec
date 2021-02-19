import { Component, OnInit } from '@angular/core';
import { Product } from 'src/app/models/product.model';
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

  constructor(private apiService: ProductApiRequestService) {
    //console.log(this.products.findIndex(s => s.id === 1), this.products.find(s => s.id === 1));
    this.apiService.listProducts().subscribe(success => {
      if (success) {
        console.log("OK")
      }
      else {
        console.log("ERROR")
        alert("ERROR!!!");
      }
    });
  }

  ngOnInit(): void {

  }

}
