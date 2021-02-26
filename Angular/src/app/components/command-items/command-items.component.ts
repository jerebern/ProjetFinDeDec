import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CommandProduct } from 'src/app/models/command-product';
import { Product } from 'src/app/models/product.model';
import { ProductApiRequestService } from 'src/app/services/product-api-request.services';

@Component({
  selector: '[app-command-items]',
  templateUrl: './command-items.component.html',
  styleUrls: ['./command-items.component.css']
})
export class CommandItemsComponent implements OnInit {
  @Input() commandProduct!: CommandProduct;
  product !: Product
  constructor(private apiProductService: ProductApiRequestService, private router: Router) {


  }

  ngOnInit(): void {
    this.apiProductService.showProduct(this.commandProduct.product_id).subscribe(result => {
      this.product = result

    })
  }
  loadProduct(id: number) {
    this.router.navigate(['/products/' + id])
  }
}
