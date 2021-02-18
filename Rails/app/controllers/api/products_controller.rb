class Api::ProductsController < ApplicationController
    def index
        @products = Product.all.with_attached_picture
        render json: @products.map { |product|
            product.as_json.merge({ picture: url_for(product.picture) })
        }
    end
    
    def show
        @product = Product.find(params[:id])
        render json: @product.as_json.merge({ picture: url_for(@product.picture) })
    end
    
    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            render json: @product.as_json.merge({ picture: url_for(@product.picture) })
        else
            render json: @product.errors, status: :unprocessable_entity 
        end
    end
    
    def destroy
        @product = Product.find(params[:id])
        @deletedProduct = @product
        @product.destroy
        render json: @product, status: :ok
    end
    
    private
    def product_params
        params.require(:product).permit(:category, :price, :title, :description, :quantity, :animal_type, :picture)
    end

end
