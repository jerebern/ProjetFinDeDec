class Api::CommandsController < ApplicationController
    def index
        user = User.find(params[:id])
        render json: user.commands
    end
    def show 
        @command = Command.find(params[:id])
        render json: @command
    end
    
end
