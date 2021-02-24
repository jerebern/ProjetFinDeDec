class CommandProduct < ApplicationRecord
    validates :quantity, presence: true
    has_one: product
    has_one: command
end
