import { Component, OnInit } from '@angular/core';
import { Command } from 'src/app/models/command.model';
import { ApiRequestService } from 'src/app/services/api-request.services';
import { AuthService } from 'src/app/services/auth.services';

@Component({
  selector: 'app-command',
  templateUrl: './commands-view.component.html',
  styleUrls: ['./commands-view.component.css']
})
export class CommandsViewComponent implements OnInit {
  
  currentCommand !: Command 
  constructor(private apiRequestService : ApiRequestService, private authService:AuthService) { 
    this.getCurrentCommandNumber();
  }

  getCurrentCommandNumber(){
    this.apiRequestService.getOneCommandFromOneUser(this.authService.currentUser,"1").subscribe(succes =>{
      if(succes){
      this.currentCommand = this.apiRequestService.getCurrentCommand();
      }
    })
  }
  getAllCommand(){

  }
  ngOnInit(): void {
  }

}
