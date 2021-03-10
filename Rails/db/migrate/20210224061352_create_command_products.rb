class CreateCommandProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :command_products do |t|
      t.integer :quantity, null: false
      t.decimal :total_price, precision: 8, scale: 2, null: false
      t.decimal :unit_price, precision: 8, scale: 2, null: false
      t.references :product,null: false, foreign_key: true
      t.references :command, null: false, foreign_key: true
      t.timestamps
      
    end

  end
end
