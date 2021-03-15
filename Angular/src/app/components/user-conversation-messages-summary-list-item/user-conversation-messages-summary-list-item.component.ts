import { Component, Input, OnInit } from '@angular/core';
import { UserConversationMessagesSummary } from 'src/app/models/user-conversation-messages-summary';

@Component({
  selector: '[app-user-conversation-messages-summary-list-item]',
  templateUrl: './user-conversation-messages-summary-list-item.component.html',
  styleUrls: ['./user-conversation-messages-summary-list-item.component.css']
})
export class UserConversationMessagesSummaryListItemComponent implements OnInit {

  @Input() userCMSummary!: UserConversationMessagesSummary;

  constructor() { }

  ngOnInit(): void {
  }

  statusCondition(){
    if(this.userCMSummary.status=="En cours"){
      return true;
    }else{
      return false;
    }
  }

}
