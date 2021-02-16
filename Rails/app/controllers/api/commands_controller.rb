class Api::CommandsController < ApplicationController
    def index
        @commands = Command.all
        render json: @commands
    end
    def show 
        @command = Command.find(params[:id])
        render json: @command
    end
    
end
