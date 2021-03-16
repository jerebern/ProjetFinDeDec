import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
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
  sortStatus: string = "statusDown";
  sort: string = "";
  searchConversationsForm: FormGroup;
  filterConversationsForm: FormGroup;
  filterMode: string = "Tout";

  types = ["Titre", "Nom", "Email"];
  filters = ["Tout", "En cours", "Terminer"];

  constructor(private conversationService: ConversationApiRequestService, private authService: AuthService, private router: Router) {
    this.searchConversationsForm = new FormGroup({
      search: new FormControl('', Validators.required),
      type: new FormControl(this.types[0])
    });

    this.filterConversationsForm = new FormGroup({
      filter: new FormControl(this.filters[0])
    });

    this.getConversations("");
  }

  ngOnInit(): void {
  }

  getConversations(sortMode: string){
    if(this.authService.currentUser)
    {
      this.conversationService.getConversationsAdmin(sortMode).subscribe(response => {
        if(response){
          this.conversations = response;
          console.log("Conversations: ", this.conversations);
        }
      })
    }

    if(this.searchConversationsForm.get("search")?.value != ""){
      this.searchConversationsForm = new FormGroup({
        search: new FormControl(''),
        type: new FormControl(this.types[0])
      });
    }

    this.filterConversationsForm = new FormGroup({
      filter: new FormControl(this.filters[0])
    });

    this.filterMode = "Tout";
  }

  conversationClicked(conversation: Conversation){
    console.log("ConversationClicked: ", conversation);

    //this.conversationService.getOneConversation(conversation.id.toString());
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

    this.sort = this.sortFullname;

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

    this.sort = this.sortEmail;

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

    this.sort = this.sortCreationDate;

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

    this.sort = this.sortTitle;

    this.getConversations(this.sortTitle);
  }

  sortByStatus(){
    console.log("sortByStatus: ", this.sortStatus);

    if(this.sortStatus == "statusDown"){
      this.sortStatus = "statusUp";
    }else{
      this.sortStatus = "statusDown";
    }
    console.log("sortByStatus: ", this.sortStatus);

    this.sort = this.sortStatus;

    this.getConversations(this.sortStatus);
  }

  searchConversations(){
    let search = this.searchConversationsForm.get("search")?.value;
    let type = this.searchConversationsForm.get("type")?.value;
    let querry = type + "(*)" + search + "(*)" + this.filterMode;
    this.conversationService.searchConversation(querry).subscribe(response => {
      if(response){
        this.conversations = response;
        console.log("Conversation.length: ", this.conversations.length);

      }
    })
  }

  filterConversations(){
    let filter = this.filterConversationsForm.get("filter")?.value;
    this.filterMode = filter;
    this.conversationService.filterConversations(filter).subscribe(response => {
      if(response){
        this.conversations = response;
      }
    })
  }
}
