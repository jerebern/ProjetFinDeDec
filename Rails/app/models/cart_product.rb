class CartProduct < ApplicationRecord
    before_validation :calculate_price
    validates :total_price, presence: true, allow_blank: false, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 0}
    validates :quantity, presence: true, allow_blank: false, numericality: {greater_than_or_equal_to: 1}
    validates :cart_id, uniqueness: { scope: :product_id }
    belongs_to :cart
    belongs_to :product
    after_save :update_cart
    after_destroy :update_cart

    def calculate_price
        if self.quantity > self.product.quantity
            self.quantity = self.product.quantity
        end
        self.total_price = self.quantity * self.product.price
    end

    def update_cart
        self.cart.sub_total = self.cart.cart_products.sum(:total_price)
        if !self.cart.save #d'un coup que...
            errors.add(:base, self.cart.errors)
        end
    end
end
