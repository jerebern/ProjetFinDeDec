import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { element } from 'protractor';
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
  sortMode : string = "lowTotal"
  searchCommandForm: FormGroup;
  constructor(private authService : AuthService, private apiResquestService : ApiRequestService, private router : Router) {
    this.currentUser = new User;
    this.searchCommandForm = new FormGroup({
      search: new FormControl('')
    })
 
   }
  sortBy(){

    switch(this.sortMode){
      case "lowTotal":
      this.sortMode = "highTotal"  
      console.log("Sort");
      break;
      case "highTotal":
        this.sortMode = "lowTotal"         
        console.log("Sort");
      break;
    }
    this.userCommands = this.apiResquestService.getcurrentCommands(this.sortMode)
  }
  ngOnInit(): void {
    if(this.authService.currentUser != null){
      console.log("Current User : ", this.authService.currentUser)
      this.currentUser = this.authService.currentUser;      
       this.apiResquestService.getAllCommandFromOneUser(this.authService.currentUser.id.toString()).subscribe(succes =>{
         if(succes){
           this.userCommands = this.apiResquestService.getcurrentCommands("")
         }
       })
    }
    else{
      console.log("Current User : ", this.authService.currentUser)
    }

  }
  searchCommand(){
   
    let querry = this.searchCommandForm.get('search')?.value
    console.log(querry)
   this.userCommands = this.userCommands.filter((element)=>{
      return element.state.includes(querry)
    })
    console.log(this.userCommands)
  }
  loadCommand(id :number ){
    this.router.navigate(['/commands/'+id])
  }

}
