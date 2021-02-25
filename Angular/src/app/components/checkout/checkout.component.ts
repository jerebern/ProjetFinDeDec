import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.services';
import { CommandApiRequestService } from 'src/app/services/command-api-request.service';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.css']
})
export class CheckoutComponent implements OnInit {

  constructor(private commandApiRequestService : CommandApiRequestService, private authService : AuthService) { }

  ngOnInit(): void {
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
