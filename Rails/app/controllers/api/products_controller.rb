class Api::ProductsController < ApplicationController
    def index
        if params[:q]
            if @products = Product.all.with_attached_picture
                render json: @products.where("title LIKE ?", "%" + params[:q] + "%").or(@products.where("description LIKE ?", "%" + params[:q] + "%")).or(@products.where("category LIKE ?", "%" + params[:q] + "%")).or(@products.where("animal_type LIKE ?", "%" + params[:q] + "%")).map { |product|
                    product.as_json.merge({ picture: url_for(product.picture) })
                }
            else
                render json: @product.errors, status: :unprocessable_entity 
            end
        else
            if @products = Product.all.with_attached_picture
                render json: @products.map { |product|
                    product.as_json.merge({ picture: url_for(product.picture) })
                }
            else
                render json: @product.errors, status: :unprocessable_entity 
            end
        end
    end
    
    def show
        if @product = Product.find(params[:id])
            render json: @product.as_json.merge({ picture: url_for(@product.picture) })
        else
            render json: @product.errors, status: :unprocessable_entity 
        end
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
        if current_user.is_admin==false
            redirect_to ''
        else
            @product = Product.find(params[:id])
            if @product.destroy
                render json: @product, status: :ok
            else
                render json: @product.errors, status: :unprocessable_entity 
            end
        end
    end
    
    private
    def product_params
        params.require(:product).permit(:category, :price, :title, :description, :quantity, :animal_type, :picture)
    end

end
