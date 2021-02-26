import { ThrowStmt } from '@angular/compiler';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Command } from 'src/app/models/command.model';
import { AuthService } from 'src/app/services/auth.services';
import { CommandApiRequestService } from 'src/app/services/command-api-request.service';
import { CommandProductApiRequestService } from 'src/app/services/command-product-api-request.service';

@Component({
  selector: 'app-command',
  templateUrl: './commands-view.component.html',
  styleUrls: ['./commands-view.component.css']
})
export class CommandsViewComponent implements OnInit {

  currentCommand: Command;

  sortUnit : string = "priceUnitDown"
  sortQuantity : string = "quantityUp"
  sortTotalPrice : string = "priceTotalUp"
  searchCommandForm: FormGroup;
  constructor(private apiRequestService: CommandApiRequestService, private authService: AuthService, private route: ActivatedRoute, private router: Router, private apiCommandProductService : CommandProductApiRequestService) {
    this.currentCommand = new Command();
    this.searchCommandForm = new FormGroup({
      search: new FormControl('')
    })
  }
  searchCommand(){
    let querry = this.searchCommandForm.get('search')?.value
    if(this.authService.currentUser){
      this.apiCommandProductService.searchCommandProduct(this.authService.currentUser.id.toString(),this.currentCommand.id.toString(),querry).subscribe(success =>{
        this.currentCommand.command_products = success
    })
  }
}
  sortByUnitPrice(){
    if(this.sortUnit==  "priceUnitDown"){
      this.sortUnit = "priceUnitlUp"
    }
    else{
      this.sortUnit=  "priceUnitDown"
    }
    this.loadCommand_Products(this.sortUnit)
  }
  sortByTotalPrice(){
    if(this.sortTotalPrice==  "priceTotalUp"){
      this.sortTotalPrice = "priceTotalDown"
    }
    else{
      this.sortTotalPrice=  "priceTotalUp"
    }
    this.loadCommand_Products(this.sortTotalPrice)
  }
  sortbyQuantity(){
    console.log(this.sortQuantity)
    if(this.sortQuantity==  "quantityUp"){
      this.sortQuantity = "quantityDown"
    }
    else{
      this.sortQuantity=  "quantityUp"
    }
    this.loadCommand_Products(this.sortQuantity)
  }
  loadCommand_Products(sortMode : string){
    if (this.authService.isLoggedIn && this.authService.currentUser != null) {
    this.apiCommandProductService.getCommandProduct(this.authService.currentUser.id.toString(),this.currentCommand.id.toString(),sortMode).subscribe(success =>{
      this.currentCommand.command_products = success
      console.log(this.currentCommand.command_products)
    })
    }
  }

  getCurrentCommandNumber(id: string) {
    if (this.authService.isLoggedIn && this.authService.currentUser != null) {
      console.log("ID string ", this.authService.currentUser)
      this.apiRequestService.getOneCommandFromOneUser(this.authService.currentUser.id.toString(), id).subscribe(succes => {
        if (succes) {
          this.currentCommand = this.apiRequestService.getCurrentCommand();
        }
        else {
          console.log("ERROR")
          alert("Produit innexistant.");
          this.router.navigate(['/products']);
        }
      })
    }
    console.log("Heloooo", this.currentCommand);

  }
  updateCommandShipping() {
    this.currentCommand.shipping_adress = "141 rue Alarie"
    if (this.authService.currentUser) {
      this.apiRequestService.updateCommand(this.currentCommand.id.toString(), this.authService.currentUser.id.toString(), this.currentCommand).subscribe(success => {
        if (success) {
          console.log("OK", success)
        }
        else {
          console.log("ERROR")
          alert("ERROR!!!");
          window.location.reload();
        }
      });
    }

  }
  cancelCommand() {
    if (this.authService.currentUser != null) {
      this.apiRequestService.deleteCommand(this.currentCommand.id.toString(), this.authService.currentUser.id.toString()).subscribe(success => {
        if (success) {
          this.router.navigate(["/profile"])
        }
        else {
          console.log("ERROR")
          alert("ERROR!!!");
        }
      });
    }
  }
  ngOnInit(): void {
    let id: string | null;
    id = this.route.snapshot.paramMap.get("id");
    if (id) {
      this.getCurrentCommandNumber(id);
    }
    else {
      console.log("Hacker man ");
    }
  }

}
