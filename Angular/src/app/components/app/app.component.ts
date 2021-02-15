import { Component, ViewEncapsulation } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ApiRequestService } from 'src/app/services/api-request.services';
import { AuthService } from 'src/app/services/auth.services';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  encapsulation: ViewEncapsulation.None
})
export class AppComponent {
  searchForm: FormGroup;

  title = 'JFJ';

  constructor(private authService: AuthService, private router: Router, private apiService: ApiRequestService) {
    this.searchForm = new FormGroup({
      itemQuerry: new FormControl
    })
    this.apiService.listProducts().subscribe(success => {
      if (success) {
        console.log("OK")
      }
      else {
        console.log("ERROR")
        alert("ERROR!!!");
      }
    });
  }

  isLoggedIn(): boolean {
    return this.authService.isLoggedIn;
  }

  logIn() {
    this.router.navigate(['/login']);
  }

  logOut() {
    this.authService.userSignout().subscribe(success => {
      if (success) {
        console.log("Utilisateur déconnecter");
        this.router.navigate(['/'])
      } else {
        console.log("Erreur");
      }
    })
  }
}
