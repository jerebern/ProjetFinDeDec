require "test_helper"

class Api::ProductsSommariesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can get all products" do
    get "/api/products_sommaries/"
    assert_equal(Product.all.count, response.parsed_body)
    assert_response :success
  end
end
