import { Component, OnInit } from '@angular/core';
import { Product } from 'src/app/models/product.model';
import { ApiRequestService } from 'src/app/services/api-request.services';

@Component({
  selector: 'app-products-list',
  templateUrl: './products-list.component.html',
  styleUrls: ['./products-list.component.css']
})
export class ProductsListComponent implements OnInit {

  get products(): Product[] {
    return this.apiService.products;
  }

  constructor(private apiService: ApiRequestService) { }

  ngOnInit(): void {
    console.log("TEST:", this.products)
  }

}
