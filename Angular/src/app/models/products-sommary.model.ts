import { JSONObject } from "ts-json-object";

export class ProductsSommary extends JSONObject {

    products_title !: string

    products_category !: string

    products_animal_type !: string

    products_price !: number

    sum_of_cart_products_quantity !: number

    average_cart_products_quantity !: number

    sum_of_cart_products_total !: number

    average_cart_products_total !: number

    products_number_of_cart !: number

    average_carts_total !: number

    created_at !: Date
}
