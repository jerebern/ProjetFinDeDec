class CreateConverations < ActiveRecord::Migration[6.0]
  def change
    create_table :converations do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
