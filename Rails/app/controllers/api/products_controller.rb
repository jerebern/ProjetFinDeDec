class Api::ProductsController < ApplicationController
    before_action :admin_required, only: [:destroy]
    def index
        if params[:q].blank?
            render json: { products: Product.all.as_json(:methods => :picture_url), success: true}
        else
            render json: { products: Product.where("MATCH(category, title, description, animal_type) AGAINST( ? )", params[:q]).as_json(:methods => :picture_url), success: true}
        end
    end
    
    def show
        @product = Product.find(params[:id])
        render json: { product: @product.as_json(:methods => :picture_url), success: true }
    end
    
    def destroy
        @product = Product.find(params[:id])
        if @product.destroy
            render json: { product: @product.as_json(:methods => :picture_url), success: true }
        else
            render json: { success: false, error: [@product.errors] }
        end
    end
    
    private
    def product_params
        params.require(:product).permit(:category, :price, :title, :description, :quantity, :animal_type, :picture)
    end
end
