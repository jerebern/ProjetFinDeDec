class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.decimal :sub_total, precision: 8, scale: 2, null: false
      t.references :user, null: false, foreign_key: true, :unique => true
      t.timestamps
      t.check_constraint("sub_total >= 0", name: "price_cart_check")
    end
  end
end
