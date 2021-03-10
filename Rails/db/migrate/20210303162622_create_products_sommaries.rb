class CreateProductsSommaries < ActiveRecord::Migration[6.1]
  def change
    execute <<-SQL
      CREATE OR REPLACE VIEW `products_sommary` AS
      select 
      p.title as products_title, 
      p.category as products_category, 
      p.animal_type as products_animal_type, 
      p.price as products_price, 
      sum(cp.quantity) as sum_of_cart_products_quantity, 
      format(avg(cp.quantity), 0, 'fr_FR') as average_cart_products_quantity, 
      sum(cp.total_price) as sum_of_cart_products_total, 
      format(avg(cp.total_price), 2, 'fr_FR') as average_cart_products_total, 
      count(cp.cart_id) as products_number_of_cart, 
      format(avg(c.sub_total), 2, 'fr_FR') as average_carts_total, 
      date_format(cp.created_at, "%m/%d/%Y") as created_at
      from products p 
      join cart_products cp 
      on p.id = cp.product_id 
      join carts c 
      on c.id = cp.cart_id 
      group by p.title;
    SQL
  end
end
