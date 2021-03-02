import { custom, JSONObject, required } from 'ts-json-object'

export class Product extends JSONObject {

    @required
    id !: number

    @required
    category !: string

    @required
    price !: string

    @required
    title !: string

    @required
    description !: string

    @required
    quantity !: string

    @required
    animal_type !: string

    picture_url !: string
}
