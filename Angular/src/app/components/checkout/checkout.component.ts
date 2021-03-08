import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
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
  constructor(private commandApiRequestService : CommandApiRequestService, private apiCartService : CartApiRequestService,private router : Router) {

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
    this.getCommandInfo();
  }
  get cart() {
    return this._cart;
  }
  getCommandInfo(){
      this.commandApiRequestService.createCommand("false").subscribe(succes =>{
          this._tmpCommand = this.commandApiRequestService.getCurrentCommand()
      }
        
      )
    
  }

  get tmpcommand(){
    return this._tmpCommand;
  }

  sendCommand(){
      this.commandApiRequestService.createCommand("true").subscribe(succes =>{
          this.router.navigate(['/profile'])
      }
        
      )

  }

}
