class Message < ApplicationRecord
    validates :body, presence: true, length: {maximum: 2500}
    belongs_to :conversation
    belongs_to :user
end
