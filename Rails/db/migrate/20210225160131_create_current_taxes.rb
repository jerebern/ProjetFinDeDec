class CreateCurrentTaxes < ActiveRecord::Migration[6.1]
  def change
    create_table :current_taxes do |t|
      t.decimal :tps, precision: 8, scale: 2, null: false
      t.decimal :tvq, precision: 8, scale: 2, null: false
      t.timestamps
    end
  end
end
