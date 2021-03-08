import { HttpClient } from '@angular/common/http';
import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';
import { of } from 'rxjs/internal/observable/of';
import { catchError, map } from 'rxjs/operators';
import { Conversation } from 'src/app/models/conversation.model';
import { User } from 'src/app/models/user.models';
import { AuthService } from 'src/app/services/auth.services';

@Component({
  selector: '[app-admin-list-item]',
  templateUrl: './admin-list-item.component.html',
  styleUrls: ['./admin-list-item.component.css']
})
export class AdminListItemComponent implements OnInit {

  @Input() conversation!: Conversation;
  @Output() conversationClicked = new EventEmitter();
  @Output() delete = new EventEmitter();

  constructor() { }

  ngOnInit(): void {
  }

  clicked(){
    this.conversationClicked.emit(this.conversation);
  }

  deleteConversation(){
    this.delete.emit(this.conversation);
  }

  trimCreatedAt(createdAt: string){
    return createdAt.substring(0, 10);
  }

  statusCondition(){
    if(this.conversation.status=="En cours"){
      return true;
    }else{
      return false;
    }
  }
}
