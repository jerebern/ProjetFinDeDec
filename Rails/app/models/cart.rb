class Cart < ApplicationRecord
    validates :sub_total, presence: true, allow_blank: false, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0}
    has_many :cart_products
    has_many :products, through: :cart_products
    belongs_to :user
end
