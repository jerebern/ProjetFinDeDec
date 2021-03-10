import { Message } from 'src/app/models/message.model';
import { Component, Input, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Conversation } from 'src/app/models/conversation.model';
import { ConversationApiRequestService } from 'src/app/services/conversation-api-request.service';
import { AuthService } from 'src/app/services/auth.services';
import { MessageApiRequestService } from 'src/app/services/message-api-request.service';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-conversation',
  templateUrl: './conversation.component.html',
  styleUrls: ['./conversation.component.css']
})
export class ConversationComponent implements OnInit {

  conversation: Conversation;
  messageForm: FormGroup;
  editMessageForm: FormGroup;
  messagesTemp: Message[] = [];
  messages: Message[] = [];
  timeReload: number = 3000;
  private currentMessage: Message;
  updating: boolean = false;
  deleting: boolean = false;
  searchMessagesForm: FormGroup;

  constructor(private route: ActivatedRoute, private messageService: MessageApiRequestService, private conversationService: ConversationApiRequestService, private authService: AuthService) {
    this.currentMessage = new Message();

    this.messageForm = new FormGroup({
      body: new FormControl("", Validators.required)
    })

    this.editMessageForm = new FormGroup({
      body: new FormControl("", Validators.required)
    })

    this.searchMessagesForm = new FormGroup({
      search: new FormControl('')
    })

    this.conversation = new Conversation();

    this.ngOnInit();


    //setInterval(() => this.getMessages(), this.timeReload);
  }

  ngOnInit(): void {
    let id: string | null;
    id = this.route.snapshot.paramMap.get("id");
    console.log("ID ROUTE: ", id);

    if (id) {
      this.getConversation(id);
      this.getMessages();
    }
    else {
      console.log("Bernard est le meilleur");
    }
  }

  getMessages(){
    if(this.conversation){
      console.log("ConversationID: ", this.conversation.id);

      this.messageService.getAllMessages().subscribe(response => {
        if(response){
          if(this.authService.currentUser?.is_admin){
            this.messagesTemp = response;

            this.messages = [];

            for(var i = 0; i < this.messagesTemp.length; i++){
              if(this.messagesTemp[i].conversation_id == this.conversation.id){
                this.messages.push(this.messagesTemp[i]);
              }
            }
          }else{
            this.messages = response;
            console.log("Messages.length: ", this.messages.length);
            console.log("AllMessages: ", this.messages);
          }
        }
      })
    }

    if(this.searchMessagesForm.get("search")?.value != ""){
      this.searchMessagesForm.reset();
    }
  }

  getConversation(id: string){
    this.conversationService.getOneConversation(id).subscribe(response => {
      if(response){
        this.conversation = response.conversation;
      }else{
        console.log("ERROR");
      }
    })
  }

  createMessage(){
    let newMessage: Message = new Message();
    if(this.conversation)
    {
      newMessage.body = this.messageForm.get('body')?.value;
      newMessage.conversation_id = this.conversation.id;
      console.log("New Message: ", newMessage);

      this.messageService.createMessage(newMessage).subscribe(success => {
        if(success){
          console.log("Success: ", success);
          this.getMessages();
        }
      })
    }

    this.messageForm.reset();
  }

  updateTransfer(message: Message){
    this.updating = true;

    console.log("Message to update: ", message);

    this.editMessageForm.patchValue({
      body: message.body
    });

    this.currentMessage = message;
  }

  updateMessage(){
    console.log("Update Message: ", this.currentMessage);
    this.currentMessage.body = this.editMessageForm.get('body')?.value;

    this.messageService.updateMessage(this.currentMessage.id.toString(), this.currentMessage).subscribe(success => {
      if(success){
        console.log("Success: ", success);
        this.getMessages();
      }
    })

    this.updating = false;
    this.editMessageForm.reset();
  }

  delete(message: Message){
    console.log("Message to delete: ", message);

    if(confirm("Êtes-vous certain de vouloir supprimer ce message avec l'id: " + message.id +"?"))
    {
      this.messageService.deleteMessage(message.id.toString()).subscribe(success => {
          if(success){
            console.log("Delete Message: ", success);
            this.getMessages();
          }
          else{
            console.log("Delete Message ERROR: ", success);
          }
        });
    }
  }

  searchMessages(){
    let search = this.searchMessagesForm.get("search")?.value;
    this.messageService.searchMessages(search).subscribe(response => {
      if(response){
        if(this.authService.currentUser?.is_admin){
          this.messagesTemp = response;

          this.messages = [];

          for(var i = 0; i < this.messagesTemp.length; i++){
            if(this.messagesTemp[i].conversation_id == this.conversation.id){
              this.messages.push(this.messagesTemp[i]);
            }
          }
        }else{
          this.messages = response;
          console.log("Messages.length: ", this.messages.length);
          console.log("AllMessages: ", this.messages);
        }
      }
    })
  }

  cancelUpdate(){
    this.updating = false;
  }

  statusCondition(){
    if(this.conversation.status=="En cours"){
      return true;
    }else{
      return false;
    }
  }
}
