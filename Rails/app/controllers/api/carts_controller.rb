class Api::CartsController < ApplicationController
    before_action :is_currentUser?, :authenticate_user!

    def index
        @user = User.find(params[:user_id])
        @carts = @user.cart
        render json: { cart: @carts.as_json, success: true }
    rescue => e
        render json: { success: false, error: [e] }
    end

    def show
        @user = User.find(params[:user_id])
        @cart = @user.cart
        render json: { cart: @cart.as_json, success: true }
    rescue => e
        render json: { success: false, error: [e] }
    end

    def create
        @user = User.find(params[:user_id])
        @cart = @user.cart
        if @cart.create(cart_params)
            render json: { cart: @cart, success: true }
        else
            render json: { success: false, error: [@cart.errors] }
        end
    rescue => e
        render json: { success: false, error: [e] }
    end

    def update
        @user = User.find(params[:user_id])
        @cart = @user.cart
        if @cart.update(cart_params)
            render json: { cart: @cart, success: true }
        else
            render json: { success: false, error: [@cart.errors] }
        end
    rescue => e
        render json: { success: false, error: [e] }
    end

    # def destroy
    #     @user = User.find(params[:user_id])
    #     @cart = @user.cart
    #     if @cart.destroy
    #         render json: { cart: @cart, success: true }
    #     else
    #         render json: { success: false, error: [@cart.errors] }
    #     end
    # rescue => e
    #     render json: { success: false, error: [e] }
    # end
    
    private
    def is_currentUser?
        unless current_user.id == params[:user_id].to_i || current_user.is_admin == true
            render json: {success: false, error: ["You hacker XD are not the good user. LOL"]} 
        end
    rescue => e
        render json: { success: false, error: [e] }
    end

    private
    def cart_params
        params.require(:cart).permit(:sub_total, :user_id)
    end
end
