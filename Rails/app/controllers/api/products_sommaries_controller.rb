class Api::ProductsSommariesController < ApplicationController
    def index
        render json: { products_sommary: ProductsSommary.find_by_sql("SELECT * FROM products_sommary").as_json, success: true}
    end
end
