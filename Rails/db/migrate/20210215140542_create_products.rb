class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :category, :limit => 50, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.string :title, :limit => 50, null: false
      t.string :description, :limit => 2500, null: false
      t.integer :quantity, null: false
      t.string :animal_type, :limit => 50, null: false
      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE products
      ADD CONSTRAINT price_check CHECK (price > 0);
    SQL
    execute <<-SQL
      ALTER TABLE products
      ADD CONSTRAINT quantity_check CHECK (quantity >= 0);
    SQL
    execute <<-SQL
      ALTER TABLE products
      ADD FULLTEXT INDEX fulltext_products (category, title, description, animal_type);
    SQL
  end
end
