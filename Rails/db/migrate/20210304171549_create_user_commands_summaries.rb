class CreateUserCommandsSummaries < ActiveRecord::Migration[6.1]
  def change
      execute <<-SQL
      CREATE OR REPLACE VIEW `user_commands_summary` AS
      select 
      users.email as email,
      CONCAT(users.firstname ," " ,users.lastname) as fullname,
      format(avg(command_products.unit_price),2, 'fr_FR')as unit_product_value_average,
      count(command_products.quantity) as average_unit_per_product,
      format(min(commands.sub_total),2,'fr_FR') as minimum_command_value_sub_total,
      format(avg(commands.sub_total),2, 'fr_FR') as Average_command_value_sub_total,
      format(max(commands.sub_total),2,'fr_FR') as maximum_command_value_sub_total,
      format(sum(commands.total),2,'fr_FR') as total_command_value
      from users
      inner join  commands
      on  commands.user_id = users.id
      join command_products 
      on  command_products.command_id = commands.id 
      group by users.id;
      SQL
  end
end
