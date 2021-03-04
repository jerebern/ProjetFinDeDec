import { Component, Input, OnInit } from '@angular/core';
import { ProductsSommary } from 'src/app/models/products-sommary.model';

@Component({
  selector: '[app-products-sommary-list-item]',
  templateUrl: './products-sommary-list-item.component.html',
  styleUrls: ['./products-sommary-list-item.component.css']
})
export class ProductsSommaryListItemComponent implements OnInit {

  @Input() productsSommary!: ProductsSommary;

  constructor() { }

  ngOnInit(): void {
    console.log("products_sommary", this.productsSommary);
  }

}
