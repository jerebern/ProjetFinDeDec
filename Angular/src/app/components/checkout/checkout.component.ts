import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Cart } from 'src/app/models/cart.model';
import { Command } from 'src/app/models/command.model';
import { AuthService } from 'src/app/services/auth.services';
import { CartApiRequestService } from 'src/app/services/cart-api-request.service';
import { CommandApiRequestService } from 'src/app/services/command-api-request.service';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.css']
})
export class CheckoutComponent implements OnInit {
  private _cart!: Cart;
  private _tmpCommand !: Command;
  shipping_cost !: number;
  private shipping : boolean = false;

  constructor(private commandApiRequestService : CommandApiRequestService, private apiCartService : CartApiRequestService,private router : Router, private route: ActivatedRoute) {

   }

  ngOnInit(): void {
    this.apiCartService.showCart().subscribe(success => {
      if (success) {
        console.log("OK", this.apiCartService.cart);
        this._cart = this.apiCartService.cart!;
      }
      else {
        console.log("ERROR", success);
        alert("ERROR!!!");
      }
    });

    if(this.route.snapshot.paramMap.get("shipping") == "1"){
      this.shipping = true;
      this.shipping_cost =5.00
    }
    else{
      this.shipping_cost = 0.00
    }
    console.log(this.shipping)
    this.getCommandInfo();
  }
  get cart() {
    return this._cart;
  }
  getCommandInfo(){

      this.commandApiRequestService.createCommand("false",this.shipping).subscribe(succes =>{
       
        if(succes){
        
          this._tmpCommand = succes
          
        }  
      }
        
      )
    
  }

  get tmpcommand(){
    return this._tmpCommand;
  }

  sendCommand(){
      this.commandApiRequestService.createCommand("true",this.shipping).subscribe(succes =>{
          this.router.navigate(['/profile'])
      }
        
      )

  }

}
