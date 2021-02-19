require 'test_helper'

class Api::ProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

    test "Can Delete a existing product " do 
        assert_difference 'Product.count', -1 do
            delete "/api/products/0"
        end
    end

    test "Can't Delete a no existing product " do 
        assert_raises(ActiveRecord::RecordNotFound) do
            delete "/api/products/6666"
        end
    end
    test "Can get one products" do
        get "/api/products/0"
        assert_response :success
    end
    test "can get all products" do
        get "/api/products/"
        assert_response :success
    end
    test "can't can no existing product " do
        assert_raises(ActiveRecord::RecordNotFound) do
            get "/api/products/666"
        end
    end

end