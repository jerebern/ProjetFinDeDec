import { Message } from 'src/app/models/message.model';
import { Component, Input, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.services';

@Component({
  selector: '[app-conversation-list-item]',
  templateUrl: './conversation-list-item.component.html',
  styleUrls: ['./conversation-list-item.component.css']
})
export class ConversationListItemComponent implements OnInit {

  @Input() message!: Message;

  constructor(private authService: AuthService) { }

  ngOnInit(): void {
  }

  isMessageUser(){
    if(this.message.user_id == this.authService.currentUser?.id){
      return true;
    }else{
      return false;
    }
  }

}
