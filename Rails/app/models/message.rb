class Message < ApplicationRecord
    validate :message, presence: true
    belongs_to :conversation
end
