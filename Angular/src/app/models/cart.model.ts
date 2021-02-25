import { JSONObject, required } from "ts-json-object";
import { CartProduct } from "./cart-product.model";

export class Cart extends JSONObject {
    id !: number
    @required
    sub_total !: string

    cartProducts !: CartProduct[]
}
