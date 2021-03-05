class Api::CommandsController < ApplicationController
    before_action :authenticate_user!
    def index
        @user = current_user
    if params[:q] && params[:s].blank?
        render json: {commands: @user.commands.where("state LIKE ?", "%" + params[:q] + "%") ,success: true}
    else 
    case params[:s]
    when "dateReverse"
        render json: {commands: @user.commands.sort_by(&:created_at).reverse, success: true}
    when "date"
        render json: {commands: @user.commands.sort_by(&:created_at), success: true} 
    when "priceUp"
        render json: {commands: @user.commands.sort_by(&:total), success: true}
    when "priceDown"
        render json: {commands: @user.commands.sort_by(&:total).reverse, success: true}               
    else
     ## le .blank est la pour éviter le 500 double render error
     render json: {commands: @user.commands.sort_by(&:id), success:true} 
        end
    end
    end
            
    def create 
        ##ICI ON NE RECOIT UTILISE RIEN EN PARAMETRE POUR EVITER QU'UN USER RENTRE DES MENSONGE  SAUF POUR CALCULER UN ESTIMER
        ##TODO reflechir a une methode de renvoyer un false si le cart est vide 
        ## Pour le perfectionement de API
        ##Verifier si le solde de la commande est plus grand que zeor
        ## on se garde ça pour la semaine 3 - Jeremy 5h du matin
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
        if params[:shipping] == true
            @newCommand.sub_total += 14.99
        end

        @newCommand.tps = @newCommand.sub_total * CurrentTax.find(1).tps
        @newCommand.tvq = @newCommand.sub_total * CurrentTax.find(1).tvq
        @newCommand.total = (1 + (CurrentTax.find(1).tps + CurrentTax.find(1).tvq)) * @newCommand.sub_total
    
        if params[:sendCommand] == "true"
        @newCommand.shipping_adress = current_user.address+","+current_user.city+","+current_user.province+","+current_user.postal_code
        @newCommand.state = "Payé"
        @newCommand.save
        render json: {command: current_user.commands.last, success:true}
        else
        render json: {command: @newCommand, success:true}

        end

    end
    
    def show 

        @user = current_user
        if @command = @user.commands.find(params[:id])
            render json: {command: @command, command_products: @command.command_products ,success: true}
        else
            render json: @command.errors, status: :unprocessable_entity, success:false
        end
    end
    def destroy
        @user = current_user
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
        @user = current_user
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

end
