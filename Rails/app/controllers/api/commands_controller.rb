class Api::CommandsController < ApplicationController
    def index
        @commands = Command.all
        render json: @commands
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
    
end
