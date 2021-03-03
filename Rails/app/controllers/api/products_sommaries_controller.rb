class Api::ProductsSommariesController < ApplicationController
    def index
        render json: { products_sommary: ProductsSommary.all.as_json, success: true}
    end
end
