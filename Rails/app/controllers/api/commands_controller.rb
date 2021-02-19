class Api::CommandsController < ApplicationController
    def index
        
        @user = User.find(params[:user_id])
        render json: @user.commands
    end
    def show 
        @user = User.find(params[:user_id])
        @command = @user.commands.find(params[:id])
        render json: @command
    end
    def destroy
        @user = User.find(params[:user_id])
        @command = @user.commands.find(params[:id])
        @command.destroy
        render json: @command, status: :ok
    end
    def update
        @user = User.find(params[:user_id])
        @command = @user.commands.find(params[:id])
        @command.update(command_params)

    end

    private 
    def command_params
        params.require(:command).permit(:sub_total, :tps, :tvq, :total, :store_pickup, :state, :shipping_adress)
    end
    
end
