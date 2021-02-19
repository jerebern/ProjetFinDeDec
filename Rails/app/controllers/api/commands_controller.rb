class Api::CommandsController < ApplicationController
    def index
        if @user = User.find(params[:user_id])
            render json: @user.commands
        else
            render json: @user.errors, status: :unprocessable_entity 
        end
    end
    def show 
        @user = User.find(params[:user_id])
        if @command = @user.commands.find(params[:id])
            render json: @command
        else
            render json: @command.errors, status: :unprocessable_entity 
        end
    end
    def destroy
        @user = User.find(params[:user_id])
        @command = @user.commands.find(params[:id])
        if @command.destroy
            render json: @command, status: :ok
        else
            render json: @command.errors, status: :unprocessable_entity 
        end
    end
    def update
        @user = User.find(params[:user_id])
        @command = @user.commands.find(params[:id])
        if @command.update(command_params)
            render json: @command
        else
            render json: @command.errors, status: :unprocessable_entity 
        end
    end

    private 
    def command_params
        params.require(:command).permit(:sub_total, :tps, :tvq, :total, :store_pickup, :state, :shipping_adress)
    end
    
end
