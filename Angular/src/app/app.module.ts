import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './components/app/app.component'
import { LoginComponent } from './components/login/login.component';
import { SignupComponent } from './components/signup/signup.component'
import { HttpClientModule } from "@angular/common/http";
import { CartComponent } from './components/cart/cart.component';
import { CartItemsComponent } from './components/cart-items/cart-items.component';
import { CommandsViewComponent } from './components/commands-view/commands-view.component';
import { CommandItemsComponent } from './components/command-items/command-items.component';
import { ProductViewComponent } from './components/product-view/product-view.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';
import { ProductsListComponent } from './components/products-list/products-list.component';
import { ProductsListItemComponent } from './components/products-list-item/products-list-item.component';
import { RouterModule } from '@angular/router';
import { ProductsComponent } from './components/products/products.component';
import { ProfileComponent } from './components/profile/profile.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    SignupComponent,
    CartComponent,
    CartItemsComponent, 
    CommandsViewComponent,
    CommandItemsComponent,
    ProductViewComponent,
    PageNotFoundComponent,
    ProductsListComponent,
    ProductsListItemComponent,
    ProductsComponent,
    ProfileComponent,
  ],
  imports: [
    ReactiveFormsModule,
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    RouterModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
