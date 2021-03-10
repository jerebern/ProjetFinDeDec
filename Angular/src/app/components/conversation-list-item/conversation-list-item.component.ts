import { Message } from 'src/app/models/message.model';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { AuthService } from 'src/app/services/auth.services';
import { ConversationApiRequestService } from 'src/app/services/conversation-api-request.service';
import { Conversation } from 'src/app/models/conversation.model';
import { ActivatedRoute } from '@angular/router';

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

  constructor(private authService: AuthService, private conversationService: ConversationApiRequestService, private route: ActivatedRoute) {
    this.currentConversation = new Conversation();
    this.ngOnInit();
  }

  ngOnInit(): void {
    let id: string | null;
    id = this.route.snapshot.paramMap.get("id");
    console.log("ID ROUTE: ", id);

    if (id) {
      this.getConversation(id);
    }
    else {
      console.log("Bernard est le meilleur");
    }
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

  getConversation(id: string){
    this.conversationService.getOneConversation(id).subscribe(response => {
      if(response){
        this.currentConversation = response.conversation;
      }else{
        console.log("ERROR");
      }
    })
  }
}
