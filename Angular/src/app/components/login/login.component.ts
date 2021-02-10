import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  loginForm: FormGroup;

  constructor(private authService : AuthService, private router : Router) {

    this.loginForm = new FormGroup({
      email: new FormControl("", [Validators.required, Validators.email]),
      password: new FormControl("", [Validators.required, Validators.minLength(6)])
    });

  }
  ngOnInit(): void {
  }

  logIn(){
    this.authService.userLogin(this.loginForm.get("email")?.value, this.loginForm.get("password")?.value).subscribe(success => {
      if(success){
        this.router.navigate(['/']);
        console.log("la team de JFJ est trop forte")
      }
    })
  }

}
