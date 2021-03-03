class ProductSommary < ActiveRecord::Migration[6.1]
  def change
    execute <<-SQL
    CREATE  OR REPLACE VIEW `products_sommary` AS
    select p.title, pc.quantity, c.id from products p join cart_products pc on p.id = pc.product_id join carts c on c.id = pc.cart_id order by pc.quantity;
    SQL
  end
end
