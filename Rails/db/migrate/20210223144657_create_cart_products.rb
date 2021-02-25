class CreateCartProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_products do |t|
      t.decimal :total_price, precision: 8, scale: 2, null: false
      t.integer :quantity, null: false
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.timestamps
      t.check_constraint("total_price > 0", name: "price_check")
      t.check_constraint("quantity > 0", name: "quantity_check")
    end
  end
end
