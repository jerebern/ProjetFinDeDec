class CreateCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :Commands do |t|
      t.decimal :sub_total, precision: 8, scale: 2
      t.decimal :tps, precision: 8, scale: 2
      t.decimal :tvq, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.boolean :store_pickup, null: false
      t.string :state, :limit => 50, null: false
      t.string :shipping_adress, :limit => 50, null: false
      
      t.timestamps
    end
end
