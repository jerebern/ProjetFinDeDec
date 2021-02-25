import { Message } from 'src/app/models/message.model';
import { Component, Input, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Conversation } from 'src/app/models/conversation.model';
import { ConversationApiRequestService } from 'src/app/services/conversation-api-request.service';
import { AuthService } from 'src/app/services/auth.services';
import { MessageApiRequestService } from 'src/app/services/message-api-request.service';
import { ConversationListItemComponent } from '../conversation-list-item/conversation-list-item.component';

@Component({
  selector: 'app-conversation',
  templateUrl: './conversation.component.html',
  styleUrls: ['./conversation.component.css']
})
export class ConversationComponent implements OnInit {

  conversation: Conversation;
  messageForm: FormGroup;
  messagesTemp: Message[] = [];
  messages: Message[] = [];

  constructor(private messageService: MessageApiRequestService, private conversationService: ConversationApiRequestService, private authService: AuthService) {
    this.messageForm = new FormGroup({
      message: new FormControl("", [Validators.required])
    })
    this.conversation = this.getConversation();
    this.getMessages();
  }

  ngOnInit(): void {
  }

  getMessages(){
    if(this.conversation){
      console.log("ConversationUserID: ", this.conversation.user_id);

      this.messageService.getAllMessages(this.conversation.user_id?.toString()).subscribe(success => {
        if(success){
          this.messagesTemp = this.messageService.getMessages();
          console.log("MessageTemp.length: ", this.messagesTemp.length);
          if(this.messages.length >= 0){
            this.messages = [];
          }
          for(var i = 0; i < this.messagesTemp.length; i++)
          {
            console.log("this.messagesTemp[i].conversation_id: ", this.messagesTemp[i].conversation_id);
            console.log("this.conversation.id: ", this.conversation.id);
            if(this.messagesTemp[i].conversation_id == this.conversation.id){
              this.messages.push(this.messagesTemp[i]);
            }
          }
          console.log("AllMessages: ", this.messages);
        }
      })
    }
  }

  getConversation(){
    return this.conversationService.currentConversation;
  }

  createMessage(){
    let newMessage: Message = new Message();
    if(this.conversation)
    {
      newMessage.texte = this.messageForm.get('message')?.value;
      newMessage.conversation_id = this.conversation.id;
      newMessage.user_id = this.authService.currentUser?.id;
      console.log("New Message: ", newMessage);

      this.messageService.createMessage(this.conversation.user_id?.toString(), newMessage).subscribe(success => {
        if(success){
          console.log("Success: ", success);
          this.getMessages();
        }
      })
    }

    this.messageForm.reset();
  }
}
