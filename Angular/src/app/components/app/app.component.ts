import { Component, ViewEncapsulation } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ProductApiRequestService } from 'src/app/services/product-api-request.services';
import { AuthService } from 'src/app/services/auth.services';

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

  constructor(private authService: AuthService, private router: Router, private apiService: ProductApiRequestService) {
    this.searchForm = new FormGroup({
      itemQuerry: new FormControl
    })
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
  navigateProfile(){
    this.router.navigate(['/profile'])
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

  isAdmin(){
    if(this.authService.currentUser?.is_admin){
      return true;
    }
    else return false;
  }
}
