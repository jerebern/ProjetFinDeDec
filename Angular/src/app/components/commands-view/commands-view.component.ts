import { Component, OnInit } from '@angular/core';
import { ApiRequestService } from 'src/app/services/api-request.services';
import { AuthService } from 'src/app/services/auth.services';

@Component({
  selector: 'app-command',
  templateUrl: './commands-view.component.html',
  styleUrls: ['./commands-view.component.css']
})
export class CommandsViewComponent implements OnInit {


  constructor(apiRequestService : ApiRequestService, authService:AuthService) { }

  getCurrentCommandNumber(){
    
  }
  getAllCommand(){

  }
  ngOnInit(): void {
  }

}
