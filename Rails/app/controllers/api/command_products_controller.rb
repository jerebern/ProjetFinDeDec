class Api::CommandProductsController < ApplicationController
before_action :authenticate_user!, :is_currentUser?
def index
    @command = Command.find(params[:command_id])
    render json: {command_products: @command.command_products, succes: true}
end

private 
def is_currentUser?
    unless current_user.id == params[:user_id].to_i || current_user.is_admin == true
        render json: {success: false} 
    end
rescue => e
    render json: { success: false, error: [e] }
end
end
