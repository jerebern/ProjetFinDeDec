class Api::CommandsController < ApplicationController
    before_action :authenticate_user!
    def index
    if params[:q] && params[:s].blank?
        render json: {commands: current_user.commands.where("state LIKE ?", "%" + params[:q] + "%") ,success: true}
    else 
    case params[:s]
    when "dateReverse"
        render json: {commands: current_user.commands.sort_by(&:created_at).reverse, success: true}
    when "date"
        render json: {commands: current_user.commands.sort_by(&:created_at), success: true} 
    when "priceUp"
        render json: {commands: current_user.commands.sort_by(&:total), success: true}
    when "priceDown"
        render json: {commands: current_user.commands.sort_by(&:total).reverse, success: true}               
    else
     ## le .blank est la pour éviter le 500 double render error
     render json: {commands: current_user.commands.sort_by(&:id), success:true} 
        end
    end
    end
            
    def create 
        ##ICI ON NE RECOIT UTILISE RIEN EN PARAMETRE POUR EVITER QU'UN USER RENTRE DES MENSONGE  SAUF POUR CALCULER UN ESTIMER
        ##TODO reflechir a une methode de renvoyer un false si le cart est vide 
        ## Pour le perfectionement de API
        ##Verifier si le solde de la commande est plus grand que zeor
        ## on se garde ça pour la semaine 3 - Jeremy 5h du matin
        @newCommand = Command.new
        @newCommand.sub_total = 0
        @newCommand.store_pickup = false;
        current_user.cart.each do |c|
           @newCommand.command_products.new
           @newCommand.command_products.last.quantity = c.quantity
           @newCommand.command_products.last.unit_price = c.product.price
           @newCommand.command_products.last.product_id = c.product.id
           @newCommand.command_products.last.total_price = (c.quantity * c.product.price)
           @newCommand.sub_total += @newCommand.command_products.last.total_price
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
        if @newCommand.save
            render json: {command: current_user.commands.last, success:true}
        else
            raise ActiveRecord::Rollback, "Vous êtes vraiment pas suposé voir ça!"
            render json: {success: false, error:"cant't create command"}
        end
        else
        render json: {command: @newCommand, success:true}
        end
    end
    
    def show 
        render json: {command: current_user.commands.find(params[:id]), command_products: current_user.commands.find(params[:id]).command_products ,success: true}
    end
    def destroy
        ##rajouter la remise de produit en inventairw
        current_user.commands.find(params[:id]).command_products.destroy_all
        if current_user.commands.find(params[:id]).destroy
            render json: {command: "destroy", success:true}
        else
            render json: @command.errors, status: :unprocessable_entity, success:false
        end
    end
    def update
        @command = current_user.commands.find(params[:id])
        if @command.update(command_params)
            render json: {command:@command, success:true}
        else
            render json: @command.errors, status: :unprocessable_entity 
        end
    end

    private 
    def command_params
        #On evite d'accepter n'importe quoi pour ne pas avoir de remboursement ou des affaire méchante
        #Cette fonction reste la des fois que dans un avenir futur on veux mettre a jour d'autre champs
        #sans trop modifier le front end 
        params.require(:command).permit(:shipping_adress)
    end

end
