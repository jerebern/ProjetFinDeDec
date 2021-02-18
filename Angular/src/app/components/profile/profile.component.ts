import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user.models';
import { AuthService } from 'src/app/services/auth.services';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  currentUser : User
  constructor(private authService : AuthService) {
    this.currentUser = new User;
   }

  ngOnInit(): void {
    if(this.authService.currentUser != null){
      this.currentUser = this.authService.currentUser;      

    }

  }

}
