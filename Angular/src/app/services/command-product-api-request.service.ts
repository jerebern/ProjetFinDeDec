import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';
@Injectable({
  providedIn: 'root'
})
export class CommandProductApiRequestService {

  constructor(private http : HttpClient) { }

  getURL( commandID : string, command_productsID : string){
    return "/api/commands/"+commandID+"/command_products/"+command_productsID
  }
  searchCommandProduct( commandID : string, querry : string ){
    return this.http.get<any>("/api/commands/"+commandID+"/command_products/"+"?q="+querry).pipe(
      map(response => { 
          return response
        
      })
    )
  }
  getCommandProduct(commandID : string, sort : string){
    return this.http.get<any>("/commands/"+commandID+"/command_products/"+"?s="+sort).pipe(
      map(response => { 
          return response
        
      })
    )
  }
  updateCommandProduct( commandID : string, command_productsID : string){
    return this.http.patch<any>(this.getURL( commandID, command_productsID),"").pipe(
      map(response => {
        return response.command

      })
    )
  }
 deleteCommandProduct(commandID : string, command_productsID : string){

  return this.http.delete<any>(this.getURL( commandID, command_productsID)).pipe(
    map(response => { 

      return response.succes

    })
  )


 }
}
