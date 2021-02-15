import {custom, JSONObject, required} from 'ts-json-object'

export class User extends JSONObject{

 
    email !: string

    password !: string

    firstname !: string

    lastname !: string

    address !: string

    city !: string

    postal_code !: string

    province !: string

    phone_number !: string

    picture !: FormData

}
