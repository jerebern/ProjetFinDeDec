import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
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
  sortFullname: string = "fullnameDown";
  sortEmail: string = "emailDown";
  sortCreationDate: string = "creationDateDown";
  sortTitle: string = "titleDown";
  searchConversationsForm: FormGroup;

  types = ["Titre", "Name", "Email"];

  constructor(private conversationService: ConversationApiRequestService, private authService: AuthService, private router: Router) {
    this.searchConversationsForm = new FormGroup({
      search: new FormControl(''),
      type: new FormControl(this.types[0])
    })
    this.getConversations("");
  }

  ngOnInit(): void {
  }

  getConversations(sortMode: string){
    if(this.authService.currentUser)
    {
      this.conversationService.getConversationsAdmin(sortMode).subscribe(success => {
        if(success){
          this.conversations = this.conversationService.getConversations();
          console.log("Conversations: ", this.conversations);
        }
      })
    }

    if(this.searchConversationsForm.get("search")?.value != ""){
      this.searchConversationsForm = new FormGroup({
        search: new FormControl(''),
        type: new FormControl(this.types[0])
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
      this.conversationService.deleteConversation(conversation.id.toString()).subscribe(success => {
          if(success){
            console.log("Delete Conversation: ", success);
            this.getConversations("");
          }
          else{
            console.log("Delete Conversation ERROR: ", success);
          }
        });
    }
  }

  sortByFullname(){
    console.log("sortByFullname: ", this.sortFullname);
    if(this.sortFullname == "fullnameDown"){
      this.sortFullname = "fullnameUp";
    }else{
      this.sortFullname = "fullnameDown";
    }
    console.log("sortByFullname: ", this.sortFullname);

    this.getConversations(this.sortFullname);
  }
  sortByEmail(){
    console.log("sortByEmail: ", this.sortEmail);

    if(this.sortEmail == "emailDown"){
      this.sortEmail = "emailUp";
    }else{
      this.sortEmail = "emailDown";
    }
    console.log("sortByEmail: ", this.sortEmail);

    this.getConversations(this.sortEmail);
  }
  sortByCreationDate(){
    console.log("sortByCreationDate: ", this.sortCreationDate);

    if(this.sortCreationDate == "creationDateDown"){
      this.sortCreationDate = "creationDateUp";
    }else{
      this.sortCreationDate = "creationDateDown";
    }
    console.log("sortByCreationDate: ", this.sortCreationDate);

    this.getConversations(this.sortCreationDate);
  }

  sortByTitle(){
    console.log("sortByTitle: ", this.sortTitle);

    if(this.sortTitle == "titleDown"){
      this.sortTitle = "titleUp";
    }else{
      this.sortTitle = "titleDown";
    }
    console.log("sortByTitle: ", this.sortTitle);

    this.getConversations(this.sortTitle);
  }

  searchConversations(){
    let search = this.searchConversationsForm.get("search")?.value;
    let type = this.searchConversationsForm.get("type")?.value;
    let querry = search + "^" + type;
    this.conversationService.searchConversation(querry).subscribe(success => {
      if(success){
        this.conversations = this.conversationService.getConversations();
      }
    })
  }
}
