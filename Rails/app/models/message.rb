class Message < ApplicationRecord
    validates :message, presence: true
    belongs_to :conversation
end
