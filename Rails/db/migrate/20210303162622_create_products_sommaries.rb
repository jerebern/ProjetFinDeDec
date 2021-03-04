class CreateProductsSommaries < ActiveRecord::Migration[6.1]
  def change
    execute <<-SQL
      CREATE OR REPLACE VIEW `products_sommary` AS
      select 
      p.title as products_title, 
      p.category as products_category, 
      p.animal_type as products_animal_type, 
      p.price as products_price, 
      sum(pc.quantity) as sum_of_cart_products_quantity, 
      format(avg(pc.quantity), 0, 'fr_FR') as average_cart_products_quantity, 
      sum(pc.total_price) as sum_of_cart_products_total, 
      format(avg(pc.total_price), 2, 'fr_FR') as average_cart_products_total, 
      count(pc.cart_id) as products_number_of_cart, 
      format(avg(c.sub_total), 2, 'fr_FR') as average_carts_total 
      from products p 
      join cart_products pc 
      on p.id = pc.product_id 
      join carts c 
      on c.id = pc.cart_id 
      group by p.title;
    SQL
  end
end
