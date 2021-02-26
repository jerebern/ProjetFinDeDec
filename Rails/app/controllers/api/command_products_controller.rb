class Api::CommandProductsController < ApplicationController
before_action :authenticate_user!, :is_currentUser?
def index
    @command = Command.find(params[:command_id])
    render json: {command_products: @command.command_products, succes: true}
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
private 
def is_currentUser?
    unless current_user.id == params[:user_id].to_i || current_user.is_admin == true
        render json: {success: false} 
    end
rescue => e
    render json: { success: false, error: [e] }
end
end
