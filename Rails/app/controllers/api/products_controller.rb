class Api::ProductsController < ApplicationController
    def index
        if params[:q] != "" && params[:q] != nil
            if @products = Product.all.with_attached_picture
                render json: { products: @products.where("MATCH(category, title, description, animal_type) AGAINST('" + params[:q] + "')").map { |product|
                    product.as_json.merge({ picture: url_for(product.picture) })
                }, success: true } 
            else
                render json: { success: false, error: [@product.errors] }
            end
        else
            if @products = Product.all.with_attached_picture
                render json: { products: @products.map { |product|
                    product.as_json.merge({ picture: url_for(product.picture) })
                }, success: true }
            else
                render json: { success: false, error: [@product.errors] }
            end
        end
    rescue => e
        render json: { success: false, error: [e] }
    end
    
    def show
        if @product = Product.find(params[:id])
            render json: { product: @product.as_json.merge({ picture: url_for(@product.picture) }), success: true }
        else
            render json: { success: false, error: [@product.errors] }
        end
    rescue => e
        render json: { success: false, error: [e] }
    end
    
    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            render json: { product: @product.as_json.merge({ picture: url_for(@product.picture) }), success: true }
        else
            render json: { success: false, error: [@product.errors] }
        end
    rescue => e
        render json: { success: false, error: [e] }
    end

    
    def destroy
        if current_user.is_admin==false
            #redirect_to ''
        else
            @product = Product.find(params[:id])
            if @product.destroy
                render json: { product: @product.as_json.merge({ picture: url_for(@product.picture) }), success: true }
            else
                render json: { success: false, error: [@product.errors] }
            end
        end
    rescue => e
        render json: { success: false, error: [e] }
    end
    
    private
    def product_params
        params.require(:product).permit(:category, :price, :title, :description, :quantity, :animal_type, :picture)
    end

end
