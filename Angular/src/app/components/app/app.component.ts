import { Component, ViewEncapsulation } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ProductApiRequestService } from 'src/app/services/product-api-request.services';
import { AuthService } from 'src/app/services/auth.services';
import { Title } from '@angular/platform-browser';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  encapsulation: ViewEncapsulation.None
  
})
export class AppComponent {
  searchForm: FormGroup;
  navbarOpen = false;
  title = 'JFJ';

  constructor(private authService: AuthService, private router: Router, private apiService: ProductApiRequestService,private titleService: Title) {
    this.searchForm = new FormGroup({
      itemQuerry: new FormControl
    })
    titleService.setTitle("Animalerie JFJ")
  }

  toggleNavbar() {
    this.navbarOpen = !this.navbarOpen;
  }

  isLoggedIn(): boolean {
    return this.authService.isLoggedIn;
  }

  logIn() {
    this.router.navigate(['/login']);
  }

  navigateProfile() {
    this.router.navigate(['/profile']);
  }

  navigateCart() {
    console.log('cart');
    this.router.navigate(['cart']);
  }

  logOut() {
    this.authService.userSignout().subscribe(success => {
      if (success) {
        console.log("Utilisateur déconnecter");
        this.router.navigate(['/'])
      } else {
        console.log("Erreur", success);
      }
    })
  }

  isAdmin() {
    if (this.authService.currentUser?.is_admin) {
      return true;
    }
    else return false;
  }
}
