import { JSONObject } from "ts-json-object";

export class Command extends JSONObject{
    id !: number
    sub_total !: number
    
    tps !:  number

    tvq !:  number

    total !: number

    store_pickup !: boolean

    state !: string

    shipping_adress !: string
    
    created_at !: Date

    user_id         !: number
}
