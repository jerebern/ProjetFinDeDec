class Api::CommandsController < ApplicationController
    before_action :is_currentUser? || :is_admin?, :authenticate_user!
    def index

       
        @user = User.find(params[:user_id])
    if params[:q]
    
         @commands =  @user.commands.where("state LIKE ?", "%" + params[:q] + "%")
    
        render json: {commands: @commands ,success: true}

    elsif params[:s] == "dateReverse"

        render json: {commands: @user.commands.sort_by(&:created_at).reverse, success: true}
    elsif params[:s] == "date"

        render json: {commands: @user.commands.sort_by(&:created_at), success: true} 
    elsif params[:s] == "priceUp"

        render json: {commands: @user.commands.sort_by(&:total), success: true}
    elsif params[:s] == "priceDown"
        
        render json: {commands: @user.commands.sort_by(&:total).reverse, success: true}               
    else
        if @user = User.find(params[:user_id])
            render json: {commands: @user.commands.sort_by(&:id), success:true} 
        else
            render json: @user.errors, status: :unprocessable_entity 
        end
    end


    end
            
    def create 
        ##ICI ON NE RECOIT UTILISE RIEN EN PARAMETRE POUR EVITER QU'UN USER RENTRE DES MENSONGE  SAUF POUR CALCULER UN ESTIMER
        @cart = current_user.cart
        @newCommand = Command.new
        @cartProducts = @cart.cart_products
        @newCommand.sub_total = 0
        @newCommand.store_pickup = false;
        @cartProducts.each do |c|
           @newCommand.command_products.new
           @newCommand.command_products.last.quantity = c.quantity
           @newCommand.command_products.last.unit_price = c.product.price
           @newCommand.command_products.last.product_id = c.product.id
           @newCommand.command_products.last.total_price = (c.quantity * c.product.price)
           @newCommand.sub_total = @newCommand.sub_total + @newCommand.command_products.last.total_price
        end
        @newCommand.user_id = current_user.id
        @newCommand.tps = @newCommand.sub_total * CurrentTax.find(1).tps
        @newCommand.tvq = @newCommand.sub_total * CurrentTax.find(1).tvq
        @newCommand.total = (1 + (CurrentTax.find(1).tps + CurrentTax.find(1).tvq)) * @newCommand.sub_total
    
        if params[:sendCommand] == "true"
        @newCommand.shipping_adress = current_user.address+","+current_user.city+","+current_user.province+","+current_user.postal_code
        @newCommand.state = "Payé"
        @newCommand.save
        render json: {command: Command.last, success:true}
        else
        render json: {command: @newCommand, success:true}

        end

    end
    def show 

        @user = User.find(params[:user_id])
        if @command = @user.commands.find(params[:id])
            render json: {command: @command, command_products: @command.command_products ,success: true}
        else
            render json: @command.errors, status: :unprocessable_entity, success:false
        end
    end
    def destroy
        @user = User.find(params[:user_id])
        @command = @user.commands.find(params[:id])
        @command.command_products.each do |p|
            p.destroy
        end
        if @command.destroy
            render json: {command: @command, success:true}
        else
            render json: @command.errors, status: :unprocessable_entity, success:false
        end
    end
    def update
        @user = User.find(params[:user_id])
        @command = @user.commands.find(params[:id])
        if @command.update(command_params)
            render json: {command:@command, success:true}
        else
            render json: @command.errors, status: :unprocessable_entity 
        end
    end

    private 
    def command_params
        params.require(:command).permit(:sub_total, :tps, :tvq, :total, :store_pickup, :state, :shipping_adress)
    end
    def is_currentUser?
        unless current_user.id == params[:user_id].to_i || current_user.is_admin == true
            render json: {success: false} 
        end
    rescue => e
        render json: { success: false, error: [e] }
    end
end
