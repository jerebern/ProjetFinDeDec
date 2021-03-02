import { JSONObject } from "ts-json-object";

export class Conversation extends JSONObject{
  id!: number;
  title!: string;
  user_id!: string
  description!: string;
}
