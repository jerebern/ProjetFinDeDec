import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './components/app/app.component'
import { LoginComponent } from './components/login/login.component';
import { SignupComponent } from './components/signup/signup.component'
import { HttpClientModule } from "@angular/common/http";

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    SignupComponent
  ],
  imports: [
    BrowserModule,
<<<<<<< HEAD
    AppRoutingModule,
    HttpClientModule,
=======
    ReactiveFormsModule,
    AppRoutingModule
>>>>>>> cc5c366a191f644bcb10ca7062e5ab6d782c167e
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
