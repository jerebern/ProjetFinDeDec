import { JSONObject } from "ts-json-object";
import { Product } from "./product.model";

export class CartProduct extends JSONObject {

    quantity !: string;

    products !: Product[];

    total_price !: string;
}
