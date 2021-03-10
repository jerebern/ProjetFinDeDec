class Api::CommandProductsController < ApplicationController
before_action :authenticate_user!, :is_currentUser?
def index
    #@productID = Array.new
    @command = Command.find(params[:command_id])

    @productsName = Product.where(id:[@command.command_products.all.select(:product_id)]).all.select(:title, :id)
     
    if params[:q]
        #@products = Product.where("MATCH(title)AGAINST( ? )",params[:q])
        #ca paserait par la en temps normal..
        #manque a faire la relation mais bon... 
        #@commandsProduct=  @command.command_products.where("MATCH(product_id)AGAINST( ? )",params[:q].to_i)
        #@productsName = Product.where(id:[@command.command_products.all.select(:product_id)]).all.select(:title)
        #@productsName.where(("MATCH(product_id)AGAINST( ? )",params[:q].to_i))
        @commandsProduct=  @command.command_products.where("product_id LIKE ?","%" +params[:q]+"%")
        @productsName = Product.where(id:[@command.command_products.all.select(:product_id)]).all.select(:title)
        
        render json: {command_products: @commandsProduct, productName: @productsName ,success: true}
    elsif params[:s] == "priceTotalUp"
        render json: {command_products: @command.command_products.sort_by(&:total_price), productName: @productsName, succes: true}
    
    elsif params[:s] == "priceTotalDown"
        render json: {command_products: @command.command_products.sort_by(&:total_price).reverse, productName: @productsName, succes: true}
   
    elsif params[:s] == "priceUnitlUp"
        render json: {command_products: @command.command_products.sort_by(&:unit_price), productName: @productsName, succes: true}
    
    elsif params[:s] == "priceUnitDown"
        render json: {command_products: @command.command_products.sort_by(&:unit_price).reverse, productName: @productsName, succes: true}

    elsif params[:s] == "quantityUp"
        render json: {command_products: @command.command_products.sort_by(&:quantity), productName: @productsName, succes: true}
    
    elsif params[:s] == "quantityDown"
       
        render json: {command_products: @command.command_products.sort_by(&:quantity).reverse, productName: @productsName, succes: true}
    else
        render json: {command_products: @command.command_products, productName: @productsName,succes: true}
        #todo rajouter un s a succes sans tout faire planter
    end
end
def destroy
    #ici on recacule la commande pour balancer dans les chiffres 
    #todo semaine 3 verifier en inventaire si le produit est dispo avant de commander
    @command = Command.find(params[:command_id])
    @command.sub_total = @command.sub_total - @command.command_products.find(params[:id]).total_price
    @command.tps = @command.sub_total * CurrentTax.find(1).tps
    @command.tvq = @command.sub_total * CurrentTax.find(1).tvq
    @command.total = (1 + (CurrentTax.find(1).tps + CurrentTax.find(1).tvq)) * @command.sub_total
    if @command.command_products.find(params[:id]).destroy
        if @command.command_products.count == 0
            @command.destroy
            render json: {command: "destroy", succes: true}
        else 
            @command.save
            render json: {succes: true}
        end
    else
        render json: {succes: false}
    end
end

def update
    #ici on recacule la commande pour balancer dans les chiffres 
    #demo pour la presentation a moment donner faut livrer :(
    @command = Command.find(params[:command_id])
    @product = @command.command_products.find(params[:id])
    @product.quantity += 1
    @product.total_price = @product.total_price + @product.unit_price
    @command.sub_total = @command.sub_total + @command.command_products.find(params[:id]).unit_price
    @command.tps = @command.sub_total * CurrentTax.find(1).tps
    @command.tvq = @command.sub_total * CurrentTax.find(1).tvq
    @command.total = (1 + (CurrentTax.find(1).tps + CurrentTax.find(1).tvq)) * @command.sub_total
    ##TODO vefifier la quantite en inventaire avant incrementation
    @product.save
    @command.save
    render json:{command: @command, succes:true}
end

private 
def is_currentUser?
   
    unless current_user.id == Command.find(params[:command_id]).user_id.to_i 
        render json: {success: false} 
    end
rescue => e
    render json: { success: false, error: [e] }
end
end
