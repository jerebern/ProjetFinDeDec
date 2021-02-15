class Api::ProductsController < ApplicationController
    def index
        @products = Product.all
        render json: @products
    end
    
    def show
        @product = Product.find(params[:id])
        render json: @product
    end
    
    def update
        @product = Product.find(params[:id])
        if @article.update(product_params)
            render json: show, status: :ok, location: @product 
        else
            render json: @product.errors, status: :unprocessable_entity 
        end
    end
    
    def delete
    end
    private
    def product_params
        params.require(:product).permit(:category, :price, :title, :description, :quantity, :animal_type)
    end
end
