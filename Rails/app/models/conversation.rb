class Conversation < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    has_many :messages, dependent: :destroy
    belongs_to :user
end
