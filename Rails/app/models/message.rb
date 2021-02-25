class Message < ApplicationRecord
    validates :texte, presence: true
    belongs_to :conversation
    belongs_to :user
end
