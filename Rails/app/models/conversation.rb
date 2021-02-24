class Conversation < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :email_user, presence: true
    validates :user_id, presence: true
    has_many :messages
    belongs_to :user
end
