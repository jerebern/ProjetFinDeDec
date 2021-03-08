import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CommandProduct } from 'src/app/models/command-product';
import { Product } from 'src/app/models/product.model';
import { CommandApiRequestService } from 'src/app/services/command-api-request.service';
import { CommandProductApiRequestService } from 'src/app/services/command-product-api-request.service';

@Component({
  selector: '[app-command-items]',
  templateUrl: './command-items.component.html',
  styleUrls: ['./command-items.component.css']
})
export class CommandItemsComponent implements OnInit {
  @Input() commandProduct!: CommandProduct ;
  @Input() userID!: number ; //todo a supprimer 
  constructor(private commandProductApiService  : CommandProductApiRequestService ,private router : Router ) { 


  }

  ngOnInit(): void {
  
  }

  loadCurrentProduct(){
  }
  updateQuantity(){  
    this.commandProductApiService.updateCommandProduct(this.commandProduct.command_id.toString(),this.commandProduct.id.toString()).subscribe(result=>{

      
    })
  }


}
