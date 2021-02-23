import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Conversation } from 'src/app/models/conversation.model'
import { ConversationApiRequestService } from 'src/app/services/conversation-api-request.service';

@Component({
  selector: 'app-help',
  templateUrl: './help.component.html',
  styleUrls: ['./help.component.css']
})
export class HelpComponent implements OnInit {

  conversationForm: FormGroup;

  constructor(private conversationService : ConversationApiRequestService, private router: Router) {
    this.conversationForm = new FormGroup({
      title: new FormControl("", Validators.required),
      description: new FormControl("", Validators.required)
    })
  }

  ngOnInit(): void {
  }

  hasMessage(): boolean{
    return false;
  }

  createConversation(){
    let newConversation = new Conversation();
    newConversation.title = this.conversationForm.get('title')?.value;
    newConversation.description = this.conversationForm.get('description')?.value;
    console.log("Conversation: ", newConversation);
  }

  message(){
    this.router.navigate(['conversation']);
  }

}
