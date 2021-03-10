import { CloneVisitor } from '@angular/compiler/src/i18n/i18n_ast';
import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormControl, FormGroup, ValidationErrors, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user.models';
import { AuthService } from 'src/app/services/auth.services';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit {

  signForm: FormGroup;
  constructor(private authService: AuthService, private router: Router) {
    this.signForm = new FormGroup({
      firstname: new FormControl("", [Validators.required, Validators.pattern('^[a-zA-Z]+$')]),
      lastname: new FormControl("", [Validators.required, Validators.pattern('^[a-zA-Z]+$')]),
      email: new FormControl("", [Validators.required, Validators.email]),
      password: new FormControl("", [Validators.required, Validators.minLength(6)]),
      passwordConfirmation: new FormControl("", [Validators.required, Validators.minLength(6)]),
      address: new FormControl("", [Validators.required]),
      city: new FormControl("", [Validators.required, Validators.pattern('^[a-zA-Z]+$')]),
      postal_code: new FormControl("", [Validators.required, Validators.maxLength(6), Validators.minLength(6)]),
      province: new FormControl("", [Validators.required, Validators.pattern('^[a-zA-Z]+$')]),
      phone_number: new FormControl("", [Validators.required, Validators.maxLength(10), Validators.minLength(10), Validators.pattern('^[0-9]+$')]),
      file: new FormControl('', [Validators.required])
    }, this.passwordMatch);
  }

  private passwordMatch(form: AbstractControl): ValidationErrors | null {
    if (form.value?.password != form.value?.passwordConfirmation) {
      return { passwordConfirmationMustMatch: true };
    } else {
      return null;
    }
  }
  ngOnInit(): void {
  }
  onFileChange(event: any) {

    if (event.target.files.length > 0) {
      const file = event.target.files[0];
      this.signForm.patchValue({
        file: file
      });
    }
  }

  signUp() {
    let newUser: User = new User();
    newUser.email = this.signForm.get('email')?.value;
    newUser.password = this.signForm.get('password')?.value
    newUser.firstname = this.signForm.get('firstname')?.value
    newUser.lastname = this.signForm.get('lastname')?.value
    newUser.address = this.signForm.get('address')?.value
    newUser.city = this.signForm.get('city')?.value
    newUser.postal_code = this.signForm.get('postal_code')?.value
    newUser.province = this.signForm.get('province')?.value
    newUser.phone_number = this.signForm.get('phone_number')?.value
    newUser.picture_url = this.signForm.get('file')?.value;
    console.log("picture : ")
    console.log("SignUpform value : ", this.signForm.value);
    console.log("New user value ", newUser);
    this.authService.userRegistration(newUser, this.signForm.get('file')?.value).subscribe(success => {
      if (success) {
        this.router.navigate(['/']);
        console.log("OK")
      }
      else {
        console.log("ERROR")
        alert("ERROR!!!      une valeur est infonctionnelle");///////a modifié
      }
    }
    );
  }

}
