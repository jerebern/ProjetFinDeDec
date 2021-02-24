import { JSONObject } from "ts-json-object";

export class Conversation extends JSONObject{
  id!: number;
  title!: string;
  description!: string;
  email_user!: string | undefined;
  user_id!: number | undefined;
}
