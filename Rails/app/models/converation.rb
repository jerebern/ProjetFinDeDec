class Converation < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    has_many :messages
    belongs_to :user
end
