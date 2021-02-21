import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { SignupComponent } from './components/signup/signup.component';
import { WelcomeComponent } from './components/welcome/welcome.component';
import { CommandsViewComponent } from './components/commands-view/commands-view.component';
import { SigninupAccessGuard } from './guards/signinup-access.guard';
import { ProductViewComponent } from './components/product-view/product-view.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';
import { ProductsComponent } from './components/products/products.component';
import { ProfileComponent } from './components/profile/profile.component';
import { HelpComponent } from './components/help/help.component';
import { ConversationComponent } from './components/conversation/conversation.component';

const routes: Routes = [
  { path: 'login', component: LoginComponent, canActivate: [SigninupAccessGuard] },
  { path: 'signup', component: SignupComponent, canActivate: [SigninupAccessGuard] },
  { path: 'commands/:id', component: CommandsViewComponent},
  { path: 'products', component: ProductsComponent },
  { path: 'products/:id', component: ProductViewComponent }, //todo proteger la route
  { path: 'profile', component: ProfileComponent }, //todo proteger la route
  { path: 'conversation', component: ConversationComponent },
  { path: 'help', component: HelpComponent },
  { path: '', component: WelcomeComponent },
  { path: '**', component: PageNotFoundComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
