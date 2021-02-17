import { JSONObject } from "ts-json-object";

export class Command extends JSONObject{
    
    sub_total !: number
    
    tps !:  number

    tvq !:  number

    total !: number

    store_pickup !: boolean

    state !: string

    shipping_adress !: string

    user_id         !: number
}
