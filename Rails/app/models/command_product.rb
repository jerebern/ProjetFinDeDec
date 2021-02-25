class CommandProduct < ApplicationRecord
    validates :quantity, presence: true
    has_one :product
    belongs_to :command
    has_many :products, through: :command_products
end
