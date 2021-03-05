class Api::ProductsSommariesController < ApplicationController
    before_action :admin_required
    def index
        # "Un Switch case c'est pas mal plus sexy qu'une orgie de else if " - Jérémy Bernard 05/03/2021 a 3h du matin 

        if params[:q].blank? || params[:s].blank?
            render json: { products_sommary: ProductsSommary.find_by_sql("SELECT * FROM products_sommary").as_json, success: true}
        end
        case params[:s]
        when "EmailUp"
            render json: { products_sommary: ProductsSommary.sort_by(&email), success: true}
        when "EmailDown"
            render json: { products_sommary: ProductsSommary.sort_by(&email).reverse, success: true}
        when "AvgUnitUp" 
            render json: { products_sommary: ProductsSommary.sort_by(&unit_product_value_average), success: true}
        when "AvgUnitDown" 
            render json: { products_sommary: ProductsSommary.sort_by(&unit_product_value_average).reverse, success: true}
        when "AvgUnitProductUp" 
            render json: { products_sommary: ProductsSommary.sort_by(&average_unit_per_product), success: true}
        when "AvgUnitProductDown" 
            render json: { products_sommary: ProductsSommary.sort_by(&average_unit_per_product), success: true}
        when "MinCommandValueUp" 
            render json: { products_sommary: ProductsSommary.sort_by(&minimum_command_value_sub_total), success: true}
        when "MinCommandValueDown" 
             render json: { products_sommary: ProductsSommary.sort_by(&minimum_command_value_sub_total).reverse, success: true}
        when "MaxCommandValueUp" 
            render json: { products_sommary: ProductsSommary.sort_by(&maximum_command_value_sub_total), success: true}
        when "MaxCommandValueDown" 
            render json: { products_sommary: ProductsSommary.sort_by(&maximum_command_value_sub_total).reverse, success: true}
        when "AvgCommandValueUp" 
            render json: { products_sommary: ProductsSommary.sort_by(&Average_command_value_sub_total), success: true}
        when "AvgCommandValueDown" 
            render json: { products_sommary: ProductsSommary.sort_by(&Average_command_value_sub_total).reverse, success: true}
        when "TotalCommandValueUp" 
            render json: { products_sommary: ProductsSommary.sort_by(&total_command_value), success: true}
        when "TotalCommandValueDown" 
            render json: { products_sommary: ProductsSommary.sort_by(&total_command_value).reverse, success: true}
        else
            render json: { products_sommary: ProductsSommary.where("products_title LIKE ?", "%" + params[:q] + "%").or(ProductsSommary.where("products_category LIKE ?", "%" + params[:q] + "%")).or(ProductsSommary.where("products_animal_type LIKE ?", "%" + params[:q] + "%")).as_json, success: true}
            #render json: { products_sommary: ProductsSommary.where("MATCH(products_title, products_category, products_animal_type) AGAINST( ? )", params[:q]).as_json, success: true}
    end
end
