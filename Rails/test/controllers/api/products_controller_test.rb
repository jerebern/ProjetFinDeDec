require 'test_helper'

class Api::ProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

    test "Can Delete a existing product " do 
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        assert_difference 'Product.count', -1 do
            delete "/api/products/1"
        end
    end

    test "Can't Delete a no existing product " do 
        post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        delete "/api/products/16"
        response
        assert_equal({"success"=>false, "error"=>["Couldn't find Product with 'id'=16"]}, response.parsed_body)
    end
    test "Can get one products" do
        post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        get "/api/products/1"
        product=Product.new(response.parsed_body["products"])
        assert_equal(Product.find(1), product)
        assert_response :success
    end
    test "can get all products" do
        post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        get "/api/products/"
        assert_response :success
    end
    test "can't get not existing product " do
        post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        get "/api/products/16"
        assert_equal({"success"=>false, "error"=>["Couldn't find Product with 'id'=16"]}, response.parsed_body)
    end
    test "can update a product" do
        post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        patch "/api/products/1", params: {product: {description: "allo"}}
        assert_equal("allo", Product.find(1).description)
        assert_response :success
    end

end