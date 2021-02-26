import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';
@Injectable({
  providedIn: 'root'
})
export class CommandProductApiRequestService {

  constructor(private http : HttpClient) { }

  getURL(userID : string, commandID : string, command_productsID : string){
    return "/api/users/"+userID+"/commands/"+commandID+"/command_products/"+command_productsID
  }
  searchCommandProduct(userID : string, commandID : string, querry : string ){
    return this.http.get<any>("/api/users/"+userID+"/commands/"+commandID+"/command_products/"+"?q="+querry).pipe(
      map(response => { 
          return response.command_products
        
      })
    )
  }
  getCommandProduct(userID : string, commandID : string, sort : string){
    return this.http.get<any>("/api/users/"+userID+"/commands/"+commandID+"/command_products/"+"?s="+sort).pipe(
      map(response => { 
          return response.command_products
        
      })
    )
  }
  updateCommandProduct(userID : string, commandID : string, command_productsID : string){
    return this.http.patch<any>(this.getURL(userID, commandID, command_productsID),"").pipe(
      map(response => {
        return response.command

      })
    )
  }
 deleteCommandProduct(userID : string, commandID : string, command_productsID : string){
   console.log("test:",this.getURL(userID, commandID, command_productsID))
  return this.http.delete<any>(this.getURL(userID, commandID, command_productsID)).pipe(
    map(response => { 

      return response.succes

    })
  )


 }
}
