class Api::ProductsSommariesController < ApplicationController
    before_action :admin_required
    def index
        if params[:q].blank?
            render json: { products_sommary: ProductsSommary.find_by_sql("SELECT * FROM products_sommary").as_json, success: true}
        else
            render json: { products_sommary: ProductsSommary.joins("JOIN products ON products_sommary.products_title = products.title").where("MATCH(category, title, description, animal_type) AGAINST( ? )", params[:q]).as_json, success: true}
        end
    end
end