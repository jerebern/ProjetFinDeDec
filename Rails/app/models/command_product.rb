class CommandProduct < ApplicationRecord
    after_save :desc_inventory
    before_destroy :ajus_inventory
    validates :quantity, presence: true
    has_one :product
    belongs_to :command

     def desc_inventory
        @product = Product.find(self.product_id)
        if @product.quantity >= self.quantity 
         @product.quantity -= self.quantity 
         @product.save
        end
     end
     def ajus_inventory
        @product = Product.find(self.product_id)
        @product.quantity += self.quantity 
        @product.save
     end
    #impossible de laisser d la car dans le controller L .39 @newCommand.sub_total += @newCommand.command_products.last.total_price
    #tombe sur un null vue que ça se passe avant la creation   
    #TypeError (nil can't be coerced into BigDecimal):
end
