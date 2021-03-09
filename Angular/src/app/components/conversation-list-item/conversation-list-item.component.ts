import { Message } from 'src/app/models/message.model';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { AuthService } from 'src/app/services/auth.services';
import { ConversationApiRequestService } from 'src/app/services/conversation-api-request.service';
import { Conversation } from 'src/app/models/conversation.model';

@Component({
  selector: '[app-conversation-list-item]',
  templateUrl: './conversation-list-item.component.html',
  styleUrls: ['./conversation-list-item.component.css']
})
export class ConversationListItemComponent implements OnInit {

  @Input() message!: Message;
  @Output() update = new EventEmitter();
  @Output() delete = new EventEmitter();
  showDate: boolean = false;
  currentConversation: Conversation;

  constructor(private authService: AuthService, private conversationService: ConversationApiRequestService) {
    this.currentConversation = this.conversationService.currentConversation;
  }

  ngOnInit(): void {
  }

  isMessageUser(){
    if(this.message.user_id == this.authService.currentUser?.id){
      return true;
    }else{
      return false;
    }
  }

  updateMessage(){
    this.update.emit(this.message);
  }

  deleteMessage(){
    this.delete.emit(this.message);
  }

  trimCreatedAt(createdAt: string){
    return createdAt.substring(0, 10) + " " + createdAt.substring(11, 19);
  }

  statusCondition(){
    if(this.currentConversation.status=="En cours"){
      console.log("ConversationComponent: ", this.currentConversation);

      return true;
    }else{
      console.log("ConversationComponent: ", this.currentConversation);
      return false;
    }
  }
}
