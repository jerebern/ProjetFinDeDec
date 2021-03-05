require "test_helper"

class Api::ProductsSommariesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can get all products sommary" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/products_sommaries/"
    assert_equal(ProductsSommary.all.count, response.parsed_body['products_sommary'].count)
    assert_response :success
  end
end
