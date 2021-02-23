class Message < ApplicationRecord
    validates :message, presence: true
    belongs_to :conversation
    belongs_to :user
end
