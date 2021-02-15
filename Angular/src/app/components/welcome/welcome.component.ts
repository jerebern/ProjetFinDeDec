import { Component, OnInit } from '@angular/core';
import { ApiRequestService } from 'src/app/services/api-request.services';

@Component({
  selector: 'app-welcome',
  templateUrl: './welcome.component.html',
  styleUrls: ['./welcome.component.css']
})
export class WelcomeComponent implements OnInit {

  constructor(private apiService: ApiRequestService) { }

  ngOnInit(): void {
    this.apiService.listProducts().subscribe(success => {
      if (success) {
        console.log("OK")
      }
      else {
        console.log("ERROR")
        alert("ERROR!!!");
      }
    })
  }

}
