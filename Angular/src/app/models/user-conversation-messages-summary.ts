import { JSONObject } from "ts-json-object"

export class UserConversationMessagesSummary extends JSONObject {
  email!: string;
  fullname!: string;
  title!: string;
  number_messages!: number;
  length_messages!: number;
  avg_length_messages!: number;
  conversation_created_at!: string;
  number_days_resolution!: number;
  status!: string;
}
