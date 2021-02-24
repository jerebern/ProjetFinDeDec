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

  constructor() { }

  ngOnInit(): void {
  }

  clicked(){
    this.conversationClicked.emit(this.conversation.id.toString());
  }

  deleteConversation(){
    alert(this.conversation.title);
  }
}
