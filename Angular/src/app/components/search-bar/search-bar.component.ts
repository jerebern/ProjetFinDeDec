import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ProductApiRequestService } from 'src/app/services/product-api-request.services';

@Component({
  selector: 'app-search-bar',
  templateUrl: './search-bar.component.html',
  styleUrls: ['./search-bar.component.css']
})
export class SearchBarComponent implements OnInit {

  searchProductForm: FormGroup;

  constructor(private apiService: ProductApiRequestService, private router: Router) {
    this.searchProductForm = new FormGroup({
      search: new FormControl('')
    });
  }

  ngOnInit(): void {
  }

  search() {
    let querry = this.searchProductForm.get('search')?.value
    console.log(querry)
    this.apiService.searchProducts(querry).subscribe(success => {
      if (success) {
        console.log("OK")
        this.router.navigate(['/products']);
      }
      else {
        console.log("ERROR", success)
        alert("ERROR!!!");
      }
    });
  }

}
