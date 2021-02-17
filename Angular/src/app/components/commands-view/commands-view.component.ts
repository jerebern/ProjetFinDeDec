import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
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
  constructor(private apiRequestService : ApiRequestService, private authService:AuthService, private route: ActivatedRoute) { 
  }

  getCurrentCommandNumber(id : string){
    this.apiRequestService.getOneCommandFromOneUser(this.authService.currentUser,"1").subscribe(succes =>{
      if(succes){
      this.currentCommand = this.apiRequestService.getCurrentCommand();
      }
    })
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
