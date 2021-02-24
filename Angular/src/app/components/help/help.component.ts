import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Conversation } from 'src/app/models/conversation.model'
import { AuthService } from 'src/app/services/auth.services';
import { ConversationApiRequestService } from 'src/app/services/conversation-api-request.service';

@Component({
  selector: 'app-help',
  templateUrl: './help.component.html',
  styleUrls: ['./help.component.css']
})
export class HelpComponent implements OnInit {

  private conversations: Conversation[] = [];
  private userConversation: Conversation | undefined;

  conversationForm: FormGroup;

  constructor(private conversationService : ConversationApiRequestService, private router: Router, private authService: AuthService) {
    this.conversationForm = new FormGroup({
      title: new FormControl("", Validators.required),
      description: new FormControl("", Validators.required)
    })
  }

  ngOnInit(): void {
    this.getConversations();
  }

  hasMessage(){
    for(var i = 0; i < this.conversations.length; i ++){
      if(this.conversations[i].user_id == this.authService.currentUser?.id){
        this.conversationService.setCurrentConversation(this.conversations[i]);
        this.userConversation = this.conversationService.getCurrentConversation;
        return true;
      }
    }
    return false;
  }

  getConversations(){
    if(this.authService.currentUser)
    {
      this.conversationService.getConversationsAdmin(this.authService.currentUser.id.toString()).subscribe(success => {
        if(success){
          this.conversations = this.conversationService.getConversations();
          console.log("Conversations: ", this.conversations);
        }
      })
    }
  }

  createConversation(){
    let newConversation = new Conversation();
    newConversation.title = this.conversationForm.get('title')?.value;
    newConversation.description = this.conversationForm.get('description')?.value;
    newConversation.email_user = this.authService.currentUser?.email;
    newConversation.user_id = this.authService.currentUser?.id;
    console.log("Conversation: ", newConversation);

    this.router.navigate(['conversation/' + newConversation.id]);
  }

  message(){
    this.router.navigate(['conversation/' + this.userConversation?.id]);
  }
}
