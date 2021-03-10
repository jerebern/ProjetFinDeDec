import { JSONObject } from "ts-json-object"

export class UserCommandSummary extends JSONObject{
    email !: string
    fullname !: string
    unit_product_value_average !: number
    average_unit_per_product !: number
    minimum_command_value_sub_total !: number
    Average_command_value_sub_total !: number
    maximum_command_value_sub_total !: number
    total_command_value !: number
}
