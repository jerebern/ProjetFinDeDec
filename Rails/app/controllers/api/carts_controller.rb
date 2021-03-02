class Api::CartsController < ApplicationController
    before_action :is_currentUser?, :authenticate_user!

    def index
        if params[:q].blank?
            render json: { cart: current_user.cart.as_json.merge({ cartProducts: current_user.cart.cart_products.map{ |cartProduct|
            cartProduct.as_json.merge({ products: current_user.cart.products.where("product_id LIKE ?", cartProduct.product_id.to_s).as_json })
            }}), success: true }
        else
            render json: { cart: current_user.cart.as_json.merge({ cartProducts: current_user.cart.cart_products.map{ |cartProduct|
            cartProduct.as_json.merge({ products: current_user.cart.products.where("product_id LIKE ?", cartProduct.product_id.to_s).where("MATCH(category, title, description, animal_type) AGAINST( ? )", params[:q]).as_json })
            }}), success: true }
        end
    end

    def show
        render json: { cart: current_user.cart.as_json.merge({ cartProducts: current_user.cart.cart_products.map{ |cartProduct|
        cartProduct.as_json.merge({ products: current_user.cart.products.where("product_id LIKE ?", cartProduct.product_id.to_s).as_json })
        }}), success: true }
    end

    def create
        @cart_product = current_user.cart.cart_products.find_by(product_id: cart_params[:products][0][:id])
        if @cart_product
            @cart_product.quantity = @cart_product.quantity + cart_params[:products][0][:quantity]
        else
            @cart_product = CartProduct.new
            @cart_product.product_id = cart_params[:products][0][:id]
            @cart_product.quantity = cart_params[:quantity]
            @cart_product.cart_id = current_user.cart.id
        end
        if @cart_product.save
            render json: { cart_product: @cart_product, success: true }
        else
            render json: { success: false, error: [@cart_product.errors] }
        end
    end

    def update
        @cart_product = current_user.cart.cart_products.find_by(product_id: cart_params[:products][0][:id])
        @cart_product.quantity = cart_params[:quantity]
        if @cart_product.save
            render json: { cart_product: @cart_product, success: true }
        else
            render json: { success: false, error: [@cart_product.errors] }
        end
    end

    def destroy
        @cart_product = current_user.cart.cart_products.find_by_id(params[:id])
        if @cart_product.destroy
            render json: { cart_product: @cart_product.as_json, success: true }
        else
            render json: { success: false, error: [@cart_product.errors] }
        end
    end
    
    private
    def is_currentUser?
        unless current_user.id == params[:user_id].to_i || current_user.is_admin == true
            render json: {success: false, error: ["You hacker XD are not the good user. LOL"]} 
        end
    rescue => e
        render json: { success: false, error: [e] }
    end

    def cart_product_params
        params.require(:cart_product).permit(:quantity, :cart_id, :product_id)
    end

    def cart_params
        params.require(:cart_product).permit(:quantity, products:[:id])
    end
end
