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
      body: new FormControl("", [Validators.required])
    })
    this.conversation = this.getConversation();
    this.getMessages();
  }

  ngOnInit(): void {
  }

  getMessages(){
    if(this.conversation){
      console.log("ConversationID: ", this.conversation.id);

      this.messageService.getAllMessages(this.conversation.id?.toString()).subscribe(success => {
        if(success){
          if(this.authService.currentUser?.is_admin){
            this.messagesTemp = this.messageService.getMessages();

            this.messages = [];

            for(var i = 0; i < this.messagesTemp.length; i++){
              if(this.messagesTemp[i].conversation_id == this.conversation.id){
                this.messages.push(this.messagesTemp[i]);
              }
            }
          }else{
            this.messages = this.messageService.getMessages();
            console.log("Messages.length: ", this.messages.length);
            console.log("AllMessages: ", this.messages);
          }
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
      newMessage.body = this.messageForm.get('body')?.value;
      newMessage.conversation_id = this.conversation.id;
      console.log("New Message: ", newMessage);

      this.messageService.createMessage(this.authService.currentUser?.id.toString(), newMessage).subscribe(success => {
        if(success){
          console.log("Success: ", success);
          //this.conversation;
          this.getMessages();
        }
      })
    }

    this.messageForm.reset();
  }
}
