import { Component, Input, OnInit } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { Conversation } from 'src/app/models/conversation.model';
import { ConversationApiRequestService } from 'src/app/services/conversation-api-request.service';

@Component({
  selector: 'app-conversation',
  templateUrl: './conversation.component.html',
  styleUrls: ['./conversation.component.css']
})
export class ConversationComponent implements OnInit {

  conversations!: Conversation;
  messageForm: FormGroup;

  constructor(private conversationService: ConversationApiRequestService) {
    this.messageForm = new FormGroup({})
  }

  ngOnInit(): void {
  }

  getConversation(){

  }

}
