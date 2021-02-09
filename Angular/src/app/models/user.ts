import {custom, JSONObject, required} from 'ts-json-object'

export class User extends JSONObject{
    @required
    email !: string
    @required
    password !: string
    @required
    firstname !: string
    @required
    lastname !: string
    @required
    fullname !: string
    @required
    address !: string
    @required
    city !: string
    @required
    postal_code !: string
    @required
    province !: string
    @required
    phone_number !: string 
    @required
    is_admin !: number 
}
