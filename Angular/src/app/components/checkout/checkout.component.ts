import { Component, OnInit } from '@angular/core';
import { Cart } from 'src/app/models/cart.model';
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
  constructor(private commandApiRequestService : CommandApiRequestService, private apiCartService : CartApiRequestService,private authService : AuthService) {
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

   }

  ngOnInit(): void {
  }
  get cart() {
    return this._cart;
  }

  sendCommand(){
    if(this.authService.currentUser){
      this.commandApiRequestService.createCommand(this.authService.currentUser?.id.toString()).subscribe(succes =>{
        if(succes){
          console.log("YEah")
        }

      }
        
      )
    }


  }

}
