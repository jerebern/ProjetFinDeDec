require 'test_helper'

class Api::ProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

    test "Can Delete a existing product " do 
        assert_difference 'Product.count', -1 do
            delete "/api/products/1"
        end
    end

    test "Can't Delete a no existing product " do 
        assert_raises(ActiveRecord::RecordNotFound) do
            delete "/api/products/6666"
        end
    end
    test "Can get one products" do
        products(:one).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.jpg"), filename: 'thermometre.jpg')
        get "/api/products/1"
        assert_response :success
    end
    test "can get all products" do
        products(:one).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.jpg"), filename: 'thermometre.jpg')
        products(:two).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.jpg"), filename: 'thermometre.jpg')
        get "/api/products/"
        assert_response :success
    end
    test "can't can no existing product " do
        assert_raises(ActiveRecord::RecordNotFound) do
            get "/api/products/666"
        end
    end
    test "can update a product" do
        products(:one).picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.jpg"), filename: 'thermometre.jpg')
        patch "/api/products/1", params: {product: {description: "allo"}}
        product = Product.new(response.parsed_body)
        assert_equal("allo", product.description)
        assert_response :success
    end

end