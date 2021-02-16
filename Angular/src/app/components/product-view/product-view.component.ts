import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Product } from 'src/app/models/product.model';
import { ApiRequestService } from 'src/app/services/api-request.services';

@Component({
  selector: 'app-product-view',
  templateUrl: './product-view.component.html',
  styleUrls: ['./product-view.component.css']
})
export class ProductViewComponent implements OnInit {

  private _product: Product | null = null;

  get product(): Product {
    return this._product!;
  }

  constructor(private route: ActivatedRoute, private apiService: ApiRequestService) {
    console.log("Product Input : ", this.route.snapshot.params.id)
    this.apiService.showProduct(this.route.snapshot.params.id).subscribe(success => {
      if (success) {
        console.log("OK", success)
        this._product = success as Product;
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
