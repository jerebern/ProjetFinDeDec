import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { element } from 'protractor';
import { Command } from 'src/app/models/command.model';
import { User } from 'src/app/models/user.models';
import { AuthService } from 'src/app/services/auth.services';
import { CommandApiRequestService } from 'src/app/services/command-api-request.service';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {
  userCommands: Command[] = []
  currentUser: User
  sortMode: string = "lowTotal" //pas le temps de renomer
  sortDateMode : string = "date"
  sortPriceMode : string = "priceUp"
  sort !: string
  searchCommandForm: FormGroup;
  constructor(private authService: AuthService, private  commandApiRequestService: CommandApiRequestService, private router: Router) {
    this.currentUser = new User;
    this.searchCommandForm = new FormGroup({
      search: new FormControl('')
    })

  }
  sortByID(){
    this.loadCommandList("")
  }

  sortByPrice(){

    if(this.sortPriceMode == "priceUp"){
      this.sortPriceMode= "priceDown"
    }
    else{
      this.sortPriceMode = "priceUp"
    }
    this.loadCommandList(this.sortPriceMode)

  }

  sortBydate() {

    if(this.sortDateMode == "date"){
      this.sortDateMode = "dateReverse"
    }
    else{
      this.sortDateMode = "date"
    }
    this.loadCommandList(this.sortDateMode)


  }
  loadCommandList(mode : string){
    this.sort = mode
    if (this.authService.currentUser != null) {
      this.commandApiRequestService.getAllCommandFromOneUser(mode).subscribe(success => {
        console.log(success)
        if (success) {
          console.log("OK")
          this.userCommands = success
        }
        else {
          console.log("ERROR")
          alert("ERROR!!!");
        }
      })
    }

  }

  ngOnInit(): void {
    if (this.authService.currentUser != null) {
      console.log("Current User : ", this.authService.currentUser)
      this.currentUser = this.authService.currentUser;

      this.commandApiRequestService.getAllCommandFromOneUser("").subscribe(success => {
        console.log(success)
        if (success) {
          console.log("OK")
          this.userCommands = success
        }
        else {
          console.log("ERROR")
          alert("ERROR!!!");
        }
      })
    }
    else {
      console.log("Current User : ", this.authService.currentUser)
    }

  }
  searchCommand() {
    let querry = this.searchCommandForm.get('search')?.value

      this.commandApiRequestService.searchCommand(querry).subscribe(succes =>{
        if(succes){
          this.userCommands = succes

        }
      })


  }
  loadCommand(id: number) {
    this.router.navigate(['/commands/' + id])
  }

}
