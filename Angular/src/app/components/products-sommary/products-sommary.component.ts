import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { ProductsSommary } from 'src/app/models/products-sommary.model';
import { ProductsSommaryApiRequestService } from 'src/app/services/products-sommary-api-request.service';

@Component({
  selector: 'app-products-sommary',
  templateUrl: './products-sommary.component.html',
  styleUrls: ['./products-sommary.component.css']
})
export class ProductsSommaryComponent implements OnInit {

  productsSommaries: ProductsSommary[] = [];
  filterForm: FormGroup;
  sideBarOpen = false;
  animal_type = ['Chiens', 'Chats', 'Oiseaux', 'Reptiles et Amphibiens', 'Petits Animaux', 'Aquariophilie', 'Tous les Animaux'];
  categories = ['Accessoire et Hygiène', 'Nourriture', 'Jouet', 'Cage', 'Aquarium et Terrarium', 'Transport', 'Toutes les Catégories'];

  constructor(private apiProductsSommary: ProductsSommaryApiRequestService) {
    this.filterForm = new FormGroup({
      animal: new FormControl('Tous les Animaux'),
      category: new FormControl('Toutes les Catégories'),
      select: new FormControl('Ordre Alphabétique Croissant')
    });
  }

  ngOnInit(): void {
    this.apiProductsSommary.getSommary().subscribe(success => {
      if (success) {
        console.log("OK", success);
        this.productsSommaries = success;
        console.log(this.productsSommaries);
      }
      else {
        console.log("ERROR", success)
        alert("ERROR!!!");
      }
    });
  }

  filter() {

  }

  reset() {

  }
}
