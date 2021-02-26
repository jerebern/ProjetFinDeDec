import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './components/app/app.component'
import { LoginComponent } from './components/login/login.component';
import { SignupComponent } from './components/signup/signup.component'
import { HttpClientModule } from "@angular/common/http";
import { CartComponent } from './components/cart/cart.component';
import { CartItemsComponent } from './components/cart-list/cart-list.component';
import { CommandsViewComponent } from './components/commands-view/commands-view.component';
import { CheckoutItemsComponent } from './components/checkout-items/checkout-items.component';
import { ProductViewComponent } from './components/product-view/product-view.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';
import { ProductsListComponent } from './components/products-list/products-list.component';
import { ProductsListItemComponent } from './components/products-list-item/products-list-item.component';
import { RouterModule } from '@angular/router';
import { ProductsComponent } from './components/products/products.component';
import { ProfileComponent } from './components/profile/profile.component';
import { SearchBarComponent } from './components/search-bar/search-bar.component';
import { HelpComponent } from './components/help/help.component';
import { ConversationComponent } from './components/conversation/conversation.component';
import { AdminComponent } from './components/admin/admin.component';
import { AdminListItemComponent } from './components/admin-list-item/admin-list-item.component';
import { CartListItemComponent } from './components/cart-list-item/cart-list-item.component';
import { ConversationListItemComponent } from './components/conversation-list-item/conversation-list-item.component';
import { CheckoutComponent } from './components/checkout/checkout.component';


@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    SignupComponent,
    CartComponent,
    CartItemsComponent,
    CommandsViewComponent,
    CheckoutItemsComponent,
    ProductViewComponent,
    PageNotFoundComponent,
    ProductsListComponent,
    ProductsListItemComponent,
    ProductsComponent,
    ProfileComponent,
    SearchBarComponent,
    HelpComponent,
    ConversationComponent,
    AdminComponent,
    AdminListItemComponent,
    CartListItemComponent,
    ConversationListItemComponent,
    CheckoutComponent,

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
