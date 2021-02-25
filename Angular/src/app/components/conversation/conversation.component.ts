import { Message } from 'src/app/models/message.model';
import { Component, Input, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Conversation } from 'src/app/models/conversation.model';
import { ConversationApiRequestService } from 'src/app/services/conversation-api-request.service';
import { AuthService } from 'src/app/services/auth.services';
import { MessageApiRequestService } from 'src/app/services/message-api-request.service';

@Component({
  selector: 'app-conversation',
  templateUrl: './conversation.component.html',
  styleUrls: ['./conversation.component.css']
})
export class ConversationComponent implements OnInit {

  conversation: Conversation | null = null;
  messageForm: FormGroup;
  messages: Message[] = [];

  constructor(private messageService: MessageApiRequestService, private conversationService: ConversationApiRequestService, private authService: AuthService) {
    this.messageForm = new FormGroup({
      message: new FormControl("", [Validators.required])
    })
    this.getMessages();
    this.getConversation();
  }

  ngOnInit(): void {
  }

  getMessages(){
    if(this.authService.currentUser){
      this.messageService.getAllMessages(this.authService.currentUser.id.toString()).subscribe(success => {
        if(success){
          this.messages = this.messageService.getMessages();
          console.log("AllMessages: ", this.messages);
        }
      })
    }

  }

  getConversation(){
    this.conversation = this.conversationService.getCurrentConversation();
  }

  createMessage(){
    let newMessage: Message = new Message();
    if(this.conversation)
    {
      newMessage.texte = this.messageForm.get('message')?.value;
      newMessage.conversation_id = this.conversation.id;
      newMessage.user_id = this.authService.currentUser?.id;
      console.log("New Message: ", newMessage);
    }

    if(this.authService.currentUser)
    {
      this.messageService.createMessage(this.authService.currentUser?.id.toString(), newMessage).subscribe(success => {
        if(success){
          console.log("Success: ", success);
          this.getMessages();
        }
      })
    }

    this.messageForm.reset();

  }

}
