import { Component, ViewEncapsulation } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  encapsulation: ViewEncapsulation.None
})
export class AppComponent {
  searchForm: FormGroup;

  title = 'JFJ';

  constructor(private authService : AuthService, private router : Router){
    this.searchForm = new FormGroup({
      itemQuerry: new FormControl
    })
  }

  isLoggedIn(){

  }

  logIn(){
    this.router.navigate(['/login']);
  }

  logOut(){
    this.authService.userSignout().subscribe(success => {
      if(success){
        console.log("Utilisateur déconnecter");
        this.router.navigate(['/login'])
      }else{
        console.log("Erreur");
      }
    })
  }
}
