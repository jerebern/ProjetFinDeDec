import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { UserCommandSummary } from 'src/app/models/user-command-summary';
import { UserCommandSummariesApiRequestService } from 'src/app/services/user-command-summaries-api-request.service';

@Component({
  selector: 'app-user-command-summaries',
  templateUrl: './user-command-summaries.component.html',
  styleUrls: ['./user-command-summaries.component.css']
})
export class UserCommandSummariesComponent implements OnInit {
  userCommandSummary : UserCommandSummary[] = []
  searchCommandForm: FormGroup;
  constructor(private userCommandSummariesApiService : UserCommandSummariesApiRequestService) {
    this.searchCommandForm = new FormGroup({
      search: new FormControl('')
    })

   }

  ngOnInit(): void {
    this.userCommandSummariesApiService.getSummary().subscribe(success =>{
      this.userCommandSummary = success

    }
    )
  }
  search(){
    let query = this.searchCommandForm.get('search')?.value
    this.userCommandSummariesApiService.searchSummarybyMail(query).subscribe(success =>{
      this.userCommandSummary = success

    }
    )
  }

  sort(){

  }

}
