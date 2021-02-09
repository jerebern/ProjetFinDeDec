import { Component, ViewEncapsulation } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  encapsulation: ViewEncapsulation.None
})
export class AppComponent {
  searchForm: FormGroup;

  title = 'JFJ';

  constructor(){
    this.searchForm = new FormGroup({
      itemQuerry: new FormControl
    })
  }
}