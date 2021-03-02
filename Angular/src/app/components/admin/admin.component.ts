import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Conversation } from 'src/app/models/conversation.model';
import { User } from 'src/app/models/user.models';
import { AuthService } from 'src/app/services/auth.services';
import { ConversationApiRequestService } from 'src/app/services/conversation-api-request.service';
import { runInThisContext } from 'vm';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrls: ['./admin.component.css']
})
export class AdminComponent implements OnInit {

  conversations: Conversation[] = [];
  conversation!: Conversation;

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

  conversationClicked(conversation: Conversation){
    console.log("ConversationClicked: ", conversation);

    this.conversationService.setCurrentConversation(conversation);
    this.router.navigate(['conversation/' + conversation.id]);
  }

  delete(conversation: Conversation){
    console.log("Conversation to delete: ", conversation);

    if(confirm("Êtes-vous certain de vouloir supprimer cette conversation avec l'id: " + conversation.id +"?"))
    {
      this.conversationService.deleteConversation(conversation.user_id.toString(), conversation.id.toString()).subscribe(success => {
          if(success){
            console.log("Delete Conversation: ", success);
            this.getConversations();
          }
          else{
            console.log("Delete Conversation ERROR: ", success);
          }
        });
    }
  }
}
