import { custom, JSONObject, required } from 'ts-json-object'

export class Product extends JSONObject {
    category !: string

    price !: string

    title !: string

    description !: string

    quantity !: string

    animal_type !: string
}
