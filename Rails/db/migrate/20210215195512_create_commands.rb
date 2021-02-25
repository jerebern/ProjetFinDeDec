class CreateCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :commands do |t|
      t.decimal :sub_total, precision: 8, scale: 2, null: false
      t.decimal :tps, precision: 8, scale: 2, null: false
      t.decimal :tvq, precision: 8, scale: 2, null: false
      t.decimal :total, precision: 8, scale: 2, null: false
      t.boolean :store_pickup, null: false
      t.string :state, :limit => 50, null: false
      t.string :shipping_adress, :limit => 159, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
      end

    end
end
