class Api::CommandsController < ApplicationController
    before_action :is_currentUser? || :is_admin?, :authenticate_user!
    def index
        @user = User.find(params[:user_id])
    if params[:q]
    
        @commands =  @user.commands.where("state LIKE ?", "%" + params[:q] + "%")
      
        render json: {commands: @commands, success: true}
    else
        if @user = User.find(params[:user_id])
            render json: {commands: @user.commands, success:true} 
        else
            render json: @user.errors, status: :unprocessable_entity 
        end
    end


    end
    def show 

        @user = User.find(params[:user_id])
        if @command = @user.commands.find(params[:id])
            render json: {command: @command, success: true}
        else
            render json: @command.errors, status: :unprocessable_entity, success:false
        end
    end
    def destroy
        @user = User.find(params[:user_id])
        @command = @user.commands.find(params[:id])
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
