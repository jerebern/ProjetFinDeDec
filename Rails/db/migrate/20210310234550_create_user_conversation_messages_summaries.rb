class CreateUserConversationMessagesSummaries < ActiveRecord::Migration[6.1]
  def change
    execute <<-SQL
      CREATE OR REPLACE VIEW `user_conversation_messages_summary` AS
      select
      u.email as email,
      CONCAT(u.firstname, " ", u.lastname) as fullname,
      c.title as title,
      count(m.body) as number_messages,
      sum(length(m.body)) as length_messages,
      format(avg(length(m.body)), 0) as avg_length_messages,
      date_format(c.created_at, "%y/%m/%d") as conversation_created_at,
      DATEDIFF(date_format(c.updated_at, "%y/%m/%d"), date_format(c.created_at, "%y/%m/%d")) as number_days_resolution
      from users u 
      join conversations c 
      on c.user_id = u.id
      join messages m
      on m.conversation_id = c.id
      group by fullname;
    SQL
  end
end
