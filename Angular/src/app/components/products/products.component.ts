import { formatNumber } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { ProductApiRequestService } from 'src/app/services/product-api-request.services';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.css']
})
export class ProductsComponent implements OnInit {

  filterForm: FormGroup;

  animal_type = ['Chiens', 'Chats', 'Oiseaux', 'Reptiles et Amphibiens', 'Petits Animaux', 'Aquariophilie', 'Tous les Animaux'];
  categories = ['Accessoire et Hygiène', 'Nourriture', 'Jouet', 'Cage', 'Aquarium et Terrarium', 'Transport', 'Toutes les Catégories'];

  constructor(private apiService: ProductApiRequestService) {
    this.filterForm = new FormGroup({
      animal: new FormControl('Tous les Animaux'),
      category: new FormControl('Toutes les Catégories'),
      select: new FormControl('Ordre Alphabétique Croissant')
    });
    this.apiService.listProducts().subscribe(success => {
      if (success) {
        console.log("OK")
      }
      else {
        console.log("ERROR", success)
        alert("ERROR!!!");
      }
    });
  }

  ngOnInit(): void {
  }

  filter() {
    var sortBy;
    if (this.filterForm.get('select')?.value == "Ordre Alphabétique Croissant") {
      sortBy = 1;
    }
    else if (this.filterForm.get('select')?.value == "Ordre Alphabétique Décroissant") {
      sortBy = 2;
    }
    else if (this.filterForm.get('select')?.value == "Prix Croissant") {
      sortBy = 3;
    }
    else if (this.filterForm.get('select')?.value == "Prix Décroissant") {
      sortBy = 4;
    }
    console.log(this.filterForm.get('animal')?.value, this.filterForm.get('category')?.value, this.filterForm.get('select')?.value);
    this.apiService.filterProducts(this.filterForm.get('animal')?.value, this.filterForm.get('category')?.value, sortBy as number);
  }

  reset() {
    window.location.reload();
  }

}
