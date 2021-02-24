import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Conversation } from 'src/app/models/conversation.model';
import { AuthService } from 'src/app/services/auth.services';
import { ConversationApiRequestService } from 'src/app/services/conversation-api-request.service';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {

  conversations: Conversation[] = [];

  constructor(private conversationService: ConversationApiRequestService, private authService: AuthService, private router: Router) {
    this.getConversations();
  }

  ngOnInit(): void {
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

  conversationClicked(conversationID: string){
    this.router.navigate(['conversation/' + conversationID]);
  }
}
