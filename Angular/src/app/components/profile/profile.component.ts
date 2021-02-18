import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Command } from 'src/app/models/command.model';
import { User } from 'src/app/models/user.models';
import { ApiRequestService } from 'src/app/services/api-request.services';
import { AuthService } from 'src/app/services/auth.services';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {
  userCommands : Command[] = []
  currentUser : User
  constructor(private authService : AuthService, private apiResquestService : ApiRequestService, private router : Router) {
    this.currentUser = new User;
    
   }

  ngOnInit(): void {
    if(this.authService.currentUser != null){
      console.log("Current User : ", this.authService.currentUser)
      this.currentUser = this.authService.currentUser;      
       this.apiResquestService.getAllCommandFromOneUser(this.authService.currentUser.id.toString()).subscribe(succes =>{
         if(succes){
           this.userCommands = this.apiResquestService.getcurrentCommands()
         }
       })
    }
    else{
      console.log("Current User : ", this.authService.currentUser)
    }

  }
  loadCommand(id :number ){
    this.router.navigate(['/commands/'+id])
  }

}
