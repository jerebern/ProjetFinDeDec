class Api::CommandsController < ApplicationController
    def index
        @commands = Commands.find(params[:email])
        render json: @commands
    end
    def show 
        @command = Command.find(params[:id])
            
    end
    
end
