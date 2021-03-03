import { JSONObject } from "ts-json-object"
import { Product } from "./product.model"

export class CommandProduct extends JSONObject {
    id !: number

    quantity !: number

    total_price !: number

    unit_price !: number

    product_id !: number

    command_id !: number

    productName !: string
}
