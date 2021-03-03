class ProductsSommary < ApplicationRecord
    self.table_name = "products_sommary"
    before_validation do
        throw :abort
    end
    attribute :products_title, :string
    attribute :products_category, :string
    attribute :products_animal_type, :string
    attribute :products_price, :decimal
    attribute :sum_of_cart_products_quantity, :integer
    attribute :average_cart_products_quantity, :integer
    attribute :sum_of_cart_products_total, :decimal
    attribute :average_cart_products_total, :decimal
    attribute :products_number_of_cart, :integer
    attribute :average_carts_total, :decimal
end
ProductsSommary.find_by_sql("SELECT * FROM products_sommary").as_json
