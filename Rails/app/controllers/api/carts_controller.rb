class Api::CartsController < ApplicationController
    before_action :is_currentUser?, :authenticate_user!

    def index
        @user = current_user
        @cart = @user.cart
        render json: { cart: @cart.as_json.merge({ cartProducts: @cart.cart_products.map{ |cartProduct|
        cartProduct.as_json.merge({ products: @cart.products.where("product_id LIKE ?", "%" + cartProduct.product_id.to_s + "%").as_json })
        }}), success: true }
    rescue => e
        render json: { success: false, error: [e] }
    end

    def show
        @user = current_user
        @cart = @user.cart
        render json: { cart: @cart.as_json.merge({ cartProducts: @cart.cart_products.map{ |cartProduct|
        cartProduct.as_json.merge({ products: @cart.products.where("product_id LIKE ?", "%" + cartProduct.product_id.to_s + "%").as_json })
        }}), success: true }
    rescue => e
        render json: { success: false, error: [e] }
    end

    def create
        @user = current_user
        @cart = @user.cart
        @cart_product = CartProduct.new
        @cart_product.cart_id = @cart.id
        @newParams = params[:cart_product]
        @cart_product.quantity = @newParams[:quantity]
        @newParams = @newParams[:products]
        @cart_product.product_id = Product.find(@newParams.last[:id]).id
        @cart_product.total_price = Product.find(@cart_product.product_id).price * @cart_product.quantity
        if @cart_product.save
            @cart.sub_total = 0
            @cart.cart_products.each do |carpro|
                @cart.sub_total += carpro.total_price
            end
            if @cart.save
                render json: { cart_product: @cart_product, success: true }
            else
                render json: { success: false, error: [@cart.errors] }
            end
        else
            render json: { success: false, error: [@cart_product.errors] }
        end
    rescue => e
        render json: { success: false, error: [e] }
    end

    def update
        @user = current_user
        @cart = @user.cart
        @cart_product = @cart.cart_products.find(params[:id])
        if @cart_product.update(cart_product_params)
            @product = Product.find(@cart_product.product_id)
            @cart_product.total_price = @product.price * @cart_product.quantity
            if @cart_product.save
                @cart.sub_total = 0
                @cart.cart_products.each do |carpro|
                    @cart.sub_total += carpro.total_price
                end
                if @cart.save
                    render json: { cart: @cart.as_json.merge({ cartProducts: @cart.cart_products.map{ |cartProduct|
                    cartProduct.as_json.merge({ products: @cart.products.where("product_id LIKE ?", "%" + cartProduct.product_id.to_s + "%").as_json })
                    }}), success: true }
                else
                    render json: { success: false, error: [@cart.errors] }
                end
            else
                render json: { success: false, error: [@cart.errors] }
            end
        else
            render json: { success: false, error: [@cart_product.errors] }
        end
    rescue => e
        render json: { success: false, error: [e] }
    end

    def destroy
        @user = current_user
        @cart = @user.cart
        @cart_product = @cart.cart_products.find(params[:id])
        if @cart_product.destroy
            @cart.sub_total = 0
            @cart.cart_products.each do |carpro|
                @cart.sub_total += carpro.total_price
            end
            if @cart.save
                render json: { cart_product: @cart_product.as_json, success: true }
            else
                render json: { success: false, error: [@cart.errors] }
            end
        else
            render json: { success: false, error: [@cart_product.errors] }
        end
    rescue => e
        render json: { success: false, error: [e] }
    end
    
    private
    def is_currentUser?
        unless current_user.id == params[:user_id].to_i || current_user.is_admin == true
            render json: {success: false, error: ["You hacker XD are not the good user. LOL"]} 
        end
    rescue => e
        render json: { success: false, error: [e] }
    end

    private
    def cart_product_params
        params.require(:cart_product).permit(:quantity, :cart_id, :product_id)
    end
end
