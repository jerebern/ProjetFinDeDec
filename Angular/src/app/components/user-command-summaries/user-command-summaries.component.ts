import { Component, OnInit } from '@angular/core';
import { UserCommandSummary } from 'src/app/models/user-command-summary';
import { UserCommandSummariesApiRequestService } from 'src/app/services/user-command-summaries-api-request.service';

@Component({
  selector: 'app-user-command-summaries',
  templateUrl: './user-command-summaries.component.html',
  styleUrls: ['./user-command-summaries.component.css']
})
export class UserCommandSummariesComponent implements OnInit {
  userCommandSummary : UserCommandSummary[] = []
  constructor(private userCommandSummariesApiService : UserCommandSummariesApiRequestService) { }

  ngOnInit(): void {
    this.userCommandSummariesApiService.getSummary
  }


  sort(){
    
  }

}
