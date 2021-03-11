import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { UserConversationMessagesSummary } from 'src/app/models/user-conversation-messages-summary';
import { AuthService } from 'src/app/services/auth.services';
import { UserCommandSummariesApiRequestService } from 'src/app/services/user-command-summaries-api-request.service';
import { UserConversationMessagesSummariesApiRequestService } from 'src/app/services/user-conversation-messages-summaries-api-request.service';

@Component({
  selector: 'app-user-conversation-messages-summary',
  templateUrl: './user-conversation-messages-summary.component.html',
  styleUrls: ['./user-conversation-messages-summary.component.css']
})
export class UserConversationMessagesSummaryComponent implements OnInit {

  userCMSummaries: UserConversationMessagesSummary[] = [];
  sort: string = "";
  sortFullname: string = "fullnameDown";
  sortEmail: string = "emailDown";
  sortTitle: string = "titleDown";
  sortNbrMessages: string = "nbrMessagesDown";
  sortLgMessages: string = "lgMessagesDown";
  sortAvgMessages: string = "avgMessagesDown";
  sortCreationDate: string = "creationDateDown";
  sortResolution: string = "resolutionDown";

  searchSummaryForm: FormGroup;

  types = ["Nom", "Email", "Titre"]

  constructor(private userCMService: UserConversationMessagesSummariesApiRequestService, private authService: AuthService) {
    this.searchSummaryForm = new FormGroup({
      search: new FormControl('', Validators.required),
      type: new FormControl(this.types[0])
    })
  }

  ngOnInit(): void {
    this.getSummary("");
  }

  getSummary(sortMode: string){
    if(this.authService.currentUser){
      this.userCMService.getSummary(sortMode).subscribe(response => {
        if(response){
          this.userCMSummaries = response;
          console.log("User Conversation Messages Summary: ", this.userCMSummaries);
        }
      })
    }
  }

  sortByFullname(){

    if(this.sortFullname == "fullnameDown"){
      this.sortFullname = "fullnameUp";
    }else{
      this.sortFullname = "fullnameDown";
    }
    console.log("sortByFullname: ", this.sortFullname);

    this.sort = this.sortFullname;

    this.getSummary(this.sortFullname);
  }

  sortByEmail(){

    if(this.sortEmail == "emailDown"){
      this.sortEmail = "emailUp";
    }else{
      this.sortEmail = "emailDown";
    }
    console.log("sortByEmail: ", this.sortEmail);

    this.sort = this.sortEmail;

    this.getSummary(this.sortEmail);
  }

  sortByTitle(){

    if(this.sortTitle == "titleDown"){
      this.sortTitle = "titleUp";
    }else{
      this.sortTitle = "titleDown";
    }
    console.log("sortByTitle: ", this.sortTitle);

    this.sort = this.sortTitle;

    this.getSummary(this.sortTitle);
  }

  sortByNbrMessage(){

    if(this.sortNbrMessages == "nbrMessagesDown"){
      this.sortNbrMessages = "nbrMessagesUp";
    }else{
      this.sortNbrMessages = "nbrMessagesDown";
    }
    console.log("sortByNbrMessage: ", this.sortNbrMessages);

    this.sort = this.sortNbrMessages;

    this.getSummary(this.sortNbrMessages);
  }

  sortByLgMessage(){

    if(this.sortLgMessages == "lgMessagesDown"){
      this.sortLgMessages = "lgMessagesUp";
    }else{
      this.sortLgMessages = "lgMessagesDown";
    }
    console.log("sortByLgMessage: ", this.sortLgMessages);

    this.sort = this.sortLgMessages;

    this.getSummary(this.sortLgMessages);
  }

  sortByAvgMessage(){

    if(this.sortAvgMessages == "avgMessagesDown"){
      this.sortAvgMessages = "avgMessagesUp";
    }else{
      this.sortAvgMessages = "avgMessagesDown";
    }
    console.log("sortByAvgMessage: ", this.sortAvgMessages);

    this.sort = this.sortAvgMessages;

    this.getSummary(this.sortAvgMessages);
  }

  sortByCreationDate(){

    if(this.sortCreationDate == "creationDateDown"){
      this.sortCreationDate = "creationDateUp";
    }else{
      this.sortCreationDate = "creationDateDown";
    }
    console.log("sortByCreationDate: ", this.sortCreationDate);

    this.sort = this.sortCreationDate;

    this.getSummary(this.sortCreationDate);
  }

  sortByResolution(){

    if(this.sortResolution == "resolutionDown"){
      this.sortResolution = "resolutionUp";
    }else{
      this.sortResolution = "resolutionDown";
    }
    console.log("sortByResolution: ", this.sortResolution);

    this.sort = this.sortResolution;

    this.getSummary(this.sortResolution);
  }

}
