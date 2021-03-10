import { formatNumber } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
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
  private hasOneConversation: boolean = false;

  conversationForm: FormGroup;
  editConversationForm: FormGroup;

  constructor(private conversationService: ConversationApiRequestService, private router: Router, private authService: AuthService, private route: ActivatedRoute) {

    this.userConversation = new Conversation();

    this.ngOnInit();

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
  }

  hasConversation() {

    if (this.hasOneConversation) {
      console.log("hasConversation: ", "Vrai")
      return true;
    } else {
      console.log("hasConversation: ", "Faux")
      return false;
    }
  }

  getConversation() {
    if (this.authService.currentUser) {
      this.conversationService.getConversation().subscribe(response => {
        if (response.success == true) {
          this.userConversation = response.conversation;
          console.log("userConversation: ", this.userConversation);

          if (this.userConversation) {
            console.log("editForm: ", this.userConversation);

            this.editConversationForm.patchValue({
              title: this.userConversation.title,
              description: this.userConversation.description
            });
          }

          this.hasOneConversation = true;

        }else{
          console.log("User has no conversation");
          this.hasOneConversation = false;
        }
      })
    }
  }

  createConversation() {
    let newConversation = new Conversation();
    newConversation.title = this.conversationForm.get('title')?.value;
    newConversation.description = this.conversationForm.get('description')?.value;
    newConversation.status = "En cours";
    console.log("New Conversation: ", newConversation);

    this.conversationService.createConversation(newConversation).subscribe(success => {
      if (success) {
        console.log("Success: ", success);
        this.userConversation = newConversation;
        //this.getConversation(this.userConversation.id.toString());
        this.router.navigate(['conversation/' + newConversation.id]);
      }
    })
  }

  message() {
    this.router.navigate(['conversation/' + this.userConversation.id]);
  }

  update(status: string) {
    this.userConversation.title = this.editConversationForm.get('title')?.value;
    this.userConversation.description = this.editConversationForm.get('description')?.value;
    this.userConversation.status = status;

    console.log("New Conversation: ", this.userConversation);

    this.conversationService.updateConversation(this.userConversation.id.toString(), this.userConversation).subscribe(success => {
      if (success) {
        console.log("Success: ", success);
        this.getConversation();
        if(this.userConversation.status == "En cours"){
          this.router.navigate(['conversation/' + this.userConversation.id]);
        }
      }
    })
  }

  updateStatus(status: string) {
    this.userConversation.title = this.editConversationForm.get('title')?.value;
    this.userConversation.description = this.editConversationForm.get('description')?.value;
    this.userConversation.status = status;

    console.log("New Conversation: ", this.userConversation);

    this.conversationService.updateConversation(this.userConversation.id.toString(), this.userConversation).subscribe(success => {
      if (success) {
        console.log("Success: ", success);
        this.getConversation();
      }
    })
  }

  statusCondition(){
    if(this.hasOneConversation){
      if(this.userConversation.status=="Terminer"){
        console.log("Status Condition: ", "Terminer");
        return true;
      }else{
        console.log("Status Condition: ", "En cours");

        return false;
      }
    }
    else{
      return false;
    }
  }
}
