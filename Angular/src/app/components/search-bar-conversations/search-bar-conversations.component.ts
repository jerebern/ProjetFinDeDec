import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-search-bar-conversations',
  templateUrl: './search-bar-conversations.component.html',
  styleUrls: ['./search-bar-conversations.component.css']
})
export class SearchBarConversationsComponent implements OnInit {

  searchConversationsForm: FormGroup;

  constructor() {
    this.searchConversationsForm = new FormGroup({
      search: new FormControl('')
    })
  }

  ngOnInit(): void {
  }

}
