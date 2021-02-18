import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { ApiRequestService } from 'src/app/services/api-request.services';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.css']
})
export class ProductsComponent implements OnInit {

  filterForm: FormGroup;

  animal_type = ['Chiens', 'Chats', 'Oiseaux', 'Reptiles et Amphibiens', 'Petits Animaux', 'Aquariophilie', 'Tous les Animaux'];
  categories = ['Accessoire et Hygiène', 'Nourriture', 'Jouet', 'Cage', 'Aquarium et Terrarium', 'Transport', 'Toutes les Catégories'];

  constructor(private apiService: ApiRequestService) {
    this.filterForm = new FormGroup({
      animal: new FormControl('Tous les Animaux'),
      category: new FormControl('Toutes les Catégories')
    });
  }

  ngOnInit(): void {
  }

  filter() {
    console.log(this.filterForm.get('animal')?.value, this.filterForm.get('category')?.value);
    this.apiService.filterProducts(this.filterForm.get('animal')?.value, this.filterForm.get('category')?.value);
  }

  reset() {
    window.location.reload();
  }

}
