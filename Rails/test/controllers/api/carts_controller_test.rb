require "test_helper"

class Api::CartsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can list cart product" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/carts/"
    cart_product = response.parsed_body["cart"].as_json["cart_products"]
    assert_not_equal(nil, cart_product)
    assert_equal(User.find(1).cart.cart_products.count, cart_product.count)
  end
  test "can't get another user cart" do
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
    get "/api/users/1/carts"
    assert_equal({"success"=>false, "error"=>["You hacker XD are not the good user. LOL"]}, response.parsed_body)
  end
  test "can search cart_product with description" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/carts", params: {q: "cage"}
    cart_product = response.parsed_body
    #if the assert didn't match it would've been because the search didn't work and put fuck all in all cart_product product
    assert_equal("Cage verte adaptée pour les petits oiseaux.", cart_product.as_json['cart'].as_json['cart_products'].first.as_json['products'].first.as_json['description'].to_s)
  end
  test "can delete cart Product" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    @user = User.find(1)
    @cart = @user.cart
    @product = @cart.cart_products.first
    delete "/api/users/1/carts/1"
    cart_product = response.parsed_body['cart_product']
    assert_equal(@product.as_json, cart_product)
  end
  test "normal user can't delete cart product from another user" do
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
    delete "/api/users/1/carts/1"
    cart_product = response.parsed_body
    assert_equal({"success"=>false, "error"=>["You hacker XD are not the good user. LOL"]}, cart_product)
  end
  test "can update one cart product " do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    patch "/api/users/1/carts/10", params: {cart_product: {quantity: 5, products:[{id: 10}]}}
    result = response.parsed_body.as_json['cart_product'].as_json['quantity']
    assert_equal(5, result)
  end
end
