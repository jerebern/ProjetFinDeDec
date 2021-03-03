class CommandProduct < ApplicationRecord
    validates :quantity, presence: true
    has_one :product
    belongs_to :command
end
