import { Message } from '@angular/compiler/src/i18n/i18n_ast';
import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-conversation-list-item',
  templateUrl: './conversation-list-item.component.html',
  styleUrls: ['./conversation-list-item.component.css']
})
export class ConversationListItemComponent implements OnInit {

  @Input() message!: Message;

  constructor() { }

  ngOnInit(): void {
  }

}
