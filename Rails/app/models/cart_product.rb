class CartProduct < ApplicationRecord
    validates :total_price, presence: true, allow_blank: false, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0}
    validates :quantity, presence: true, allow_blank: false, numericality: {greater_than_or_equal_to: 0}
    belongs_to :cart
    belongs_to :product
end
