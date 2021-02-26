class Api::CommandProductsController < ApplicationController
before_action :authenticate_user!, :is_currentUser?
def index

    @command = Command.find(params[:command_id])

    if params[:q]
    
    #todo
    elsif params[:s] == "priceTotalUp"
        render json: {command_products: @command.command_products.sort_by(&:total_price), succes: true}
    
    elsif params[:s] == "priceTotalDown"
        render json: {command_products: @command.command_products.sort_by(&:total_price).reverse, succes: true}
   
    elsif params[:s] == "priceUnitlUp"
        render json: {command_products: @command.command_products.sort_by(&:unit_price), succes: true}
    
    elsif params[:s] == "priceUnitDown"
        render json: {command_products: @command.command_products.sort_by(&:unit_price).reverse, succes: true}

    elsif params[:s] == "quantityUp"
        render json: {command_products: @command.command_products.sort_by(&:quantity), succes: true}
    
    elsif params[:s] == "quantityDown"
       
        render json: {command_products: @command.command_products.sort_by(&:quantity).reverse, succes: true}
    else
        render json: {command_products: @command.command_products, succes: true}

    end
end
def destroy
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

    #demo pour la presentation a moment donner faut livrer :(
    @command = Command.find(params[:command_id])
    @command.command_products.find(params[:id]).quantity =+ 1
    @command.command_products.find(params[:id]).total_price = @command.command_products.find(params[:id]).total_price + @command.command_products.find(params[:id]).unit_price
    @command.sub_total = @command.sub_total + @command.command_products.find(params[:id]).unit_price
    @command.tps = @command.sub_total * CurrentTax.find(1).tps
    @command.tvq = @command.sub_total * CurrentTax.find(1).tvq
    @command.total = (1 + (CurrentTax.find(1).tps + CurrentTax.find(1).tvq)) * @command.sub_total
    ##TODO vefifier la quantite en inventaire avant incrementation
    @command.save
    render json:{command: @command, succes:true}
end

private 
def is_currentUser?
    unless current_user.id == params[:user_id].to_i || current_user.is_admin == true
        render json: {success: false} 
    end
rescue => e
    render json: { success: false, error: [e] }
end
end
