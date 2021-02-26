import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CommandProduct } from 'src/app/models/command-product';
import { Product } from 'src/app/models/product.model';
import { CommandApiRequestService } from 'src/app/services/command-api-request.service';
import { CommandProductApiRequestService } from 'src/app/services/command-product-api-request.service';
import { ProductApiRequestService } from 'src/app/services/product-api-request.services';

@Component({
  selector: '[app-command-items]',
  templateUrl: './command-items.component.html',
  styleUrls: ['./command-items.component.css']
})
export class CommandItemsComponent implements OnInit {
  @Input() commandProduct!: CommandProduct ;
  @Input() userID!: number ;
  product !: Product
  constructor(private apiProductService : ProductApiRequestService, private commandProductApiService  : CommandProductApiRequestService ,private router : Router ) { 


  }

  ngOnInit(): void {
    this.apiProductService.showProduct(this.commandProduct.product_id).subscribe(result => {
      this.product = result

    })
  }
  updateQuantity(){
    console.log("Hello")
    this.commandProductApiService.updateCommandProduct(this.userID.toString(),this.commandProduct.command_id.toString(),this.commandProduct.id.toString()).subscribe(result=>{
      if(result.success){
        window.location.reload()
      }
    })
  }
  deleteProduct(){
    console.log(this.commandProduct)
    this.commandProductApiService.deleteCommandProduct(this.userID.toString(),this.commandProduct.command_id.toString(),this.commandProduct.id.toString()).subscribe(result =>{
      if(result.succes){
        window.location.reload();
      }
    })
  }
  loadProduct(id: number) {
    this.router.navigate(['/products/' + id])
  }
}
