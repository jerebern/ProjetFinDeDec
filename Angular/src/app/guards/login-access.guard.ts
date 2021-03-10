import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../services/auth.services';

@Injectable({
  providedIn: 'root'
})
export class LoginAccessGuard implements CanActivate {
  constructor(private authService: AuthService, private router: Router) { }
  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {
    console.log("guard product", this.authService.isLoggedIn);
    if (this.authService.isLoggedIn) {
      return true;
    } else {
      // sinon, on peut fournir un URLTree pour rediriger l'utilisateur
      return this.router.parseUrl('/products');
    }
  }

}
