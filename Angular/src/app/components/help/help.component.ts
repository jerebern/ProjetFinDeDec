import { formatNumber } from '@angular/common';
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

  private userConversation: Conversation;

  conversationForm: FormGroup;
  editConversationForm: FormGroup;

  constructor(private conversationService: ConversationApiRequestService, private router: Router, private authService: AuthService) {
    this.userConversation = new Conversation();

    this.conversationForm = new FormGroup({
      title: new FormControl("", Validators.required),
      description: new FormControl("", Validators.required)
    })

    this.editConversationForm = new FormGroup({
      title: new FormControl("", Validators.required),
      description: new FormControl("", Validators.required)
    })
  }

  ngOnInit(): void {
    this.getConversation();
    if (this.conversationService.currentConversation) {
      this.userConversation = this.conversationService.currentConversation;
      this.editConversationForm.patchValue({
        title: this.userConversation.title,
        description: this.userConversation.description
      });
    }
  }

  hasMessage() {
    if (this.userConversation) {
      return true;
    } else {
      return false;
    }
  }

  getConversation() {
    if (this.authService.currentUser) {
      this.conversationService.getConversation(this.authService.currentUser.id.toString()).subscribe(success => {
        if (success) {
          this.userConversation = this.conversationService.currentConversation;
          console.log("userConversation: ", this.userConversation);
        }
      })
    }
  }

  createConversation() {
    let newConversation = new Conversation();
    newConversation.title = this.conversationForm.get('title')?.value;
    newConversation.description = this.conversationForm.get('description')?.value;
    console.log("New Conversation: ", newConversation);

    this.conversationService.createConversation(this.authService.currentUser?.id.toString(), newConversation).subscribe(success => {
      if (success) {
        console.log("Success: ", success);
        this.conversationService.setCurrentConversation(newConversation);
        this.getConversation();
        this.router.navigate(['conversation/' + newConversation.id]);
      }
    })
  }

  message() {
    this.router.navigate(['conversation/' + this.userConversation.id]);
  }

  update() {
    this.userConversation.title = this.editConversationForm.get('title')?.value;
    this.userConversation.description = this.editConversationForm.get('description')?.value;
    console.log("New Conversation: ", this.userConversation);

    this.conversationService.updateConversation(this.authService.currentUser?.id.toString(), this.userConversation.id.toString(), this.userConversation).subscribe(success => {
      if (success) {
        console.log("Success: ", success);
        this.conversationService.setCurrentConversation(this.userConversation);
        this.getConversation();
        this.router.navigate(['conversation/' + this.userConversation.id]);
      }
    })
  }
}
