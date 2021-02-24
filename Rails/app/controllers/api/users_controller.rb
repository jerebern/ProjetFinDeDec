class Api::UsersController < ApplicationController
    before_action :is_currentUser?, :authenticate_user!
    def show
        user = User.find(params[:id])
        render json: user
    end

    def index
        if isAdmin?
           users = User.all
            render json: users
        end
    end
    private 
    def is_currentUser?
        unless current_user.id == params[:id].to_i || current_user.is_admin == true
        render json: {success: false} 
        end
    end
    def isAdmin?
       if current_user.is_admin == true
        return true 
       else 
        return false
        end
    end
end
