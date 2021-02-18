import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Command } from 'src/app/models/command.model';
import { ApiRequestService } from 'src/app/services/api-request.services';
import { AuthService } from 'src/app/services/auth.services';

@Component({
  selector: 'app-command',
  templateUrl: './commands-view.component.html',
  styleUrls: ['./commands-view.component.css']
})
export class CommandsViewComponent implements OnInit {
  
  currentCommand : Command;
  constructor(private apiRequestService : ApiRequestService, private authService:AuthService, private route: ActivatedRoute, private router: Router) { 
  this.currentCommand = new Command();
  }

  getCurrentCommandNumber(id : string){
    if(this.authService.isLoggedIn && this.authService.currentUser != null){
      console.log("ID string ", this.authService.currentUser)
      this.apiRequestService.getOneCommandFromOneUser(this.authService.currentUser.id.toString(),id).subscribe(succes =>{
        if(succes){
            this.currentCommand = this.apiRequestService.getCurrentCommand();
        }
      })
    }
    console.log("Heloooo",this.currentCommand);
    this.currentCommand.created_at.getDate
  }
  getAllCommand(){

  }
  ngOnInit(): void {
    let id : string | null;
    id = this.route.snapshot.paramMap.get("id");
    if(id){
      this.getCurrentCommandNumber(id);
    }
    else{
      console.log("Hacker man ");
    }
  }

}
