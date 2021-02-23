class Api::CartsController < ApplicationController
    def index
        @user = User.find(params[:user_id])
        @carts = @user.cart
        render json: { product: @carts.as_json, success: true }
    end
    def show
        @user = User.find(params[:user_id])
        @cart = @user.cart.find(params[:id])
        render json: { product: @cart.as_json, success: true }
    end
    def create
    end
    def update
    end
    def destroy
    end
end
