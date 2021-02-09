import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormControl, FormGroup, ValidationErrors, Validators } from '@angular/forms';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {

  signForm: FormGroup;

  constructor() {
    this.signForm = new FormGroup({
      firstname: new FormControl("", [Validators.required, Validators.pattern('^[a-zA-Z]+$')]),
      lastname: new FormControl("", [Validators.required, Validators.pattern('^[a-zA-Z]+$')]),
      email: new FormControl("", [Validators.required, Validators.email]),
      password: new FormControl("", [Validators.required, Validators.minLength(6)]),
      passwordConfirmation: new FormControl("", [Validators.required, Validators.minLength(6)]),
      address: new FormControl("", [Validators.required]),
      city: new FormControl("", [Validators.required, Validators.pattern('^[a-zA-Z]+$')]),
      postalCode: new FormControl("", [Validators.required, Validators.maxLength(6), Validators.minLength(6)]),
      province: new FormControl("", [Validators.required, Validators.pattern('^[a-zA-Z]+$')]),
      phonenumber: new FormControl("", [Validators.required, Validators.maxLength(10), Validators.minLength(10), Validators.pattern('^[0-9]+$')])
    }, this.passwordMatch);
  }

  private passwordMatch(form: AbstractControl): ValidationErrors | null {
    if(form.value?.password != form.value?.passwordConfirmation){
      return {passwordConfirmationMustMatch: true};
    }else {
      return null;
    }
  }
  ngOnInit(): void {
  }


  signUp(){

  }

}
