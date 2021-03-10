import { ThrowStmt } from '@angular/compiler';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { UserCommandSummary } from 'src/app/models/user-command-summary';
import { UserCommandSummariesApiRequestService } from 'src/app/services/user-command-summaries-api-request.service';

@Component({
  selector: 'app-user-command-summaries',
  templateUrl: './user-command-summaries.component.html',
  styleUrls: ['./user-command-summaries.component.css']
})
export class UserCommandSummariesComponent implements OnInit {
  userCommandSummary : UserCommandSummary[] = []
  searchCommandForm: FormGroup;
  email : string = "EmailUp"
  avgUnit : string  = "AvgUnitUp"
  avgProduct : string = "AvgProductUp"
  minValue : string = "MinCommandValueUp"
  maxValue : string = "MaxCommandValueUp"
  avgValue : string = "AvgCommandValueUp"
  totalValue : string  = "TotalCommandValueUp"
  dateValue : string = "LastCommand"

  sortMode : string = "MaxCommandValueUp"

  constructor(private userCommandSummariesApiService : UserCommandSummariesApiRequestService) {
    this.searchCommandForm = new FormGroup({
      search: new FormControl('')
    })

   }

  ngOnInit(): void {
    this.userCommandSummariesApiService.getSummary().subscribe(success =>{
      this.userCommandSummary = success

    }
    )
  }
  search(){
    let query = this.searchCommandForm.get('search')?.value
    this.userCommandSummariesApiService.searchSummarybyMail(query).subscribe(success =>{
      this.userCommandSummary = success

    }
    )
  }
  private sort(mode : string){
    this.sortMode = mode
    // this.userCommandSummariesApiService.sortSummary(mode).subscribe(success =>{
    //   this.userCommandSummary = success

    // }
    // )
  }

  sortEmail(){
    if(this.email == "EmailUp"){
      this.email = "EmailDown"

      this.userCommandSummary.sort((a, b) => a.email.toLowerCase() > b.email.toLowerCase() ? 1 : -1);
    }
    else{
      this.email = "EmailUp"
      this.userCommandSummary.sort((a, b) => a.email.toLowerCase() < b.email.toLowerCase() ? 1 : -1);

    }
    this.sort(this.email);
  }
  sortAvgUnit(){
    if(this.avgUnit == "AvgUnitUp"){
      this.avgUnit = "AvgUnitDown"
      this.userCommandSummary.sort((a, b) => Number(a.unit_product_value_average) > Number(b.unit_product_value_average) ? 1 : -1)
    }
    else{
      this.avgUnit = "AvgUnitUp"
      this.userCommandSummary.sort((a, b) => Number(a.unit_product_value_average) < Number(b.unit_product_value_average) ? 1 : -1)

    }
    console.log("click")
    this.sort(this.avgUnit)
  }
  sortAvgProduct(){
    if(this.avgProduct == "AvgProductUp"){
      this.avgProduct = "AvgProductDown"
      this.userCommandSummary.sort((a, b) => Number(a.average_unit_per_product) > Number(b.average_unit_per_product) ? 1 : -1)

    }
    else{
      this.avgProduct = "AvgProductUp"
      this.userCommandSummary.sort((a, b) => Number(a.average_unit_per_product) < Number(b.average_unit_per_product) ? 1 : -1)

    }
   this.sort(this.avgProduct)
  }
  sortMinValue(){
    if(this.minValue == "MinCommandValueUp"){
      this.minValue = "MinCommandValueDown"
      this.userCommandSummary.sort((a, b) => Number(a.minimum_command_value_sub_total) < Number(b.minimum_command_value_sub_total) ? 1 : -1)
      
    }
    else{
      this.minValue = "MinCommandValueUp"
      this.userCommandSummary.sort((a, b) => Number(a.minimum_command_value_sub_total) > Number(b.minimum_command_value_sub_total) ? 1 : -1)

    }
    this.sort(this.minValue)
  }
  sortMaxValue(){
    if(this.maxValue == "MaxCommandValueUp"){
      this.maxValue = "MaxCommandValueDown"
      this.userCommandSummary.sort((a, b) => Number(a.maximum_command_value_sub_total) < Number(b.maximum_command_value_sub_total) ? 1 : -1)

    }
    else{
      this.maxValue = "MaxCommandValueUp"
      this.userCommandSummary.sort((a, b) => Number(a.maximum_command_value_sub_total) > Number(b.maximum_command_value_sub_total) ? 1 : -1)

    }
   this.sort(this.maxValue)
  }
  sortAvgValue(){
    if(this.avgProduct == "AvgCommandValueUp"){
      this.avgProduct = "AvgCommandValueDown"
      this.userCommandSummary.sort((a, b) => Number(a.Average_command_value_sub_total) < Number(b.Average_command_value_sub_total) ? 1 : -1)

    }
    else{
      this.avgProduct = "AvgCommandValueUp"
      this.userCommandSummary.sort((a, b) => Number(a.Average_command_value_sub_total) > Number(b.Average_command_value_sub_total) ? 1 : -1)

    }
    this.sort(this.avgProduct)
  }
  sortTotalValue(){
    if(this.totalValue == "TotalCommandValueUp"){
      this.totalValue = "TotalCommandValueDown"
      this.userCommandSummary.sort((a, b) => Number(a.total_command_value) < Number(b.total_command_value) ? 1 : -1)

    }
    else{
      this.totalValue = "TotalCommandValueUp"
      this.userCommandSummary.sort((a, b) => Number(a.total_command_value) > Number(b.total_command_value) ? 1 : -1)

    }
    this.sort(this.totalValue)
  }
  sortDate(){
    // nice try :P
    if(this.totalValue == "LastCommand"){
      this.totalValue = "OldestCommand"
      this.userCommandSummary.sort((a, b) => Number(a.last_command.getUTCDate) < Number(b.last_command.getUTCDate) ? 1 : -1)

    }
    else{
      this.totalValue = "LastCommand"
      this.userCommandSummary.sort((a, b) => Number(a.last_command.getUTCDate) > Number(b.last_command.getUTCDate) ? 1 : -1)

    }
    this.sort(this.totalValue)
  }


}
