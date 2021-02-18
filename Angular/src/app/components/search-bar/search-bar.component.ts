import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { ApiRequestService } from 'src/app/services/api-request.services';

@Component({
  selector: 'app-search-bar',
  templateUrl: './search-bar.component.html',
  styleUrls: ['./search-bar.component.css']
})
export class SearchBarComponent implements OnInit {

  searchProductForm: FormGroup;

  constructor(private apiService: ApiRequestService) {
    this.searchProductForm = new FormGroup({
      search: new FormControl('')
    });
  }

  ngOnInit(): void {
  }

  search() {
    console.log(this.searchProductForm.get('search')?.value);
    this.apiService.searchProduct(this.searchProductForm.get('search')?.value);
  }

}
