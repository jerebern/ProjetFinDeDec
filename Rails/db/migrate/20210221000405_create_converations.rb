class CreateConverations < ActiveRecord::Migration[6.0]
  def change
    create_table :converations do |t|
      t.string :title, :limit => 50, null: false 
      t.string :description, :limit => 2500, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
