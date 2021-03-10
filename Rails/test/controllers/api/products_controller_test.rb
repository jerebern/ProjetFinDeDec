require 'test_helper'

class Api::ProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

    test "Can Delete a existing product " do 
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        Product.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(4).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(5).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(6).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(7).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(8).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(9).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(10).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(11).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(12).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(13).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(14).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(15).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        assert_difference 'Product.count', -1 do
            delete "/api/products/1"
        end
    end

    test "Can't Delete a no existing product " do 
        post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        Product.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(4).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(5).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(6).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(7).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(8).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(9).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(10).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(11).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(12).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(13).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(14).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(15).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        delete "/api/products/16"
        response
        assert_equal({"success"=>false, "error"=>"erreur 404 page introuvable"}, response.parsed_body)
    end
    test "Can get one products" do
        post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        Product.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(4).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(5).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(6).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(7).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(8).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(9).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(10).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(11).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(12).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(13).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(14).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(15).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        get "/api/products/1"
        @product = response.parsed_body['product']
        assert_equal(Product.find(1).as_json(:methods => :picture_url), @product.as_json)
        assert_response :success
    end
    test "can get all products" do
        post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        Product.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(4).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(5).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(6).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(7).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(8).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(9).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(10).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(11).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(12).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(13).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(14).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(15).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        get "/api/products/"
        assert_equal(Product.all.count, response.parsed_body['products'].count)
        assert_response :success
    end
    test "can't get not existing product " do
        post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        Product.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(4).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(5).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(6).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(7).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(8).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(9).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(10).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(11).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(12).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(13).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(14).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        Product.find(15).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
        get "/api/products/16"
        assert_equal({"success"=>false, "error"=>"erreur 404 page introuvable"}, response.parsed_body)
    end
    # test "can update a product" do
    #     post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    #     Product.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(4).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(5).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(6).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(7).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(8).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(9).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(10).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(11).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(12).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(13).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(14).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     Product.find(15).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
    #     patch "/api/products/1", params: {product: {description: "allo"}}
    #     assert_equal("allo", Product.find(1).description)
    #     assert_response :success
    # end
end