class Api::CommandsController < ApplicationController
    def index
        
        @user = User.find(params[:user_id])
        render json: @user.commands
    end
    def show 
        @command = Command.find(params[:id])
        render json: @command
    end
    def destroy
        @user = User.find(params[:user_id])
        @command = @user.commands.find(params[:id])
        @command.destroy
        render json: @command, status: :ok
    end
    def update
        byebug 
        @user = User.find(params[:user_id])
        @command = @user.commands.find(params[:id])
        @command.update(params)

    end

    private 
    def command_params
        #todo pour la semaine #2 
    end
    
end
