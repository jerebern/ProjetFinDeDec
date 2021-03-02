import { JSONObject } from "ts-json-object";

export class Message extends JSONObject{
  id!: number;
  body!: string;
  user_id!: number | undefined;
  conversation_id!: number;
}
