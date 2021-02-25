import { JSONObject } from "ts-json-object";

export class Message extends JSONObject{
  id!: number;
  texte!: string;
  user_id!: number | undefined;
  conversation_id!: number;
}
