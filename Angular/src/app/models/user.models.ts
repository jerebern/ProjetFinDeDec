import { custom, JSONObject, required } from 'ts-json-object'
import { Conversation } from './conversation.model'

export class User extends JSONObject {
    id !: number

    email!: string


    password!: string

    firstname!: string


    lastname!: string


    address!: string


    city!: string


    postal_code!: string


    province!: string


    phone_number!: string


    picture_url!: string


    is_admin!: boolean

    fullname!: string;

    conversation!: Conversation[];

}
