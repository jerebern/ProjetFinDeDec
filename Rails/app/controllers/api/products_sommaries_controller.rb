class Api::ProductsSommariesController < ApplicationController
    before_action :admin_required
    def index
        if params[:q].blank?
            render json: { products_sommary: ProductsSommary.find_by_sql("SELECT * FROM products_sommary").as_json, success: true}
        else
            render json: { products_sommary: ProductsSommary.where("products_title LIKE ?", "%" + params[:q] + "%").or(ProductsSommary.where("products_category LIKE ?", "%" + params[:q] + "%")).or(ProductsSommary.where("products_animal_type LIKE ?", "%" + params[:q] + "%")).as_json, success: true}
            #render json: { products_sommary: ProductsSommary.where("MATCH(products_title, products_category, products_animal_type) AGAINST( ? )", params[:q]).as_json, success: true}
        end
    end
end