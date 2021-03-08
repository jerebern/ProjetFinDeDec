class Conversation < ApplicationRecord
    validates :title, presence: true, length: {maximum: 50}
    validates :description, presence: true, length: {maximum: 2500}
    has_many :messages, dependent: :destroy
    belongs_to :user
end
