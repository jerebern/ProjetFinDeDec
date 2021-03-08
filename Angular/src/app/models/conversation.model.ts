import { JSONObject } from "ts-json-object";
import { User } from "./user.models";

export class Conversation extends JSONObject{
  id!: number;
  title!: string;
  user_id!: string
  fullname!: string;
  user_email!: string;
  description!: string;
  status!: string;
  created_at!: string;
  user!: User;
}
