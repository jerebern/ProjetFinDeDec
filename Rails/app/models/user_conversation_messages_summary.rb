class UserConversationMessagesSummary < ApplicationRecord
    self.table_name = "user_conversation_messages_summary"
    before_validation do
        throw :abort
    end
    attribute :email, :string
    attribute :fullname, :string
    attribute :title, :string 
    attribute :number_messages, :integer
    attribute :length_messages, :integer
    attribute :avg_length_messages, :integer
    attribute :conversation_created_at, :string
    attribute :number_days_resolution, :integer
    attribute :status, :string
end
