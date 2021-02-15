class Api::UsersController < ApplicationController
    def show
        @user = Users.find(params[:id])
        render json: @user
    end
end
