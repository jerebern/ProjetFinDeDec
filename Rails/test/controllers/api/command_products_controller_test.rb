require "test_helper"

class Api::CommandProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can get command product" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/commands/1/command_products"
    success = response.parsed_body["succes"]
    assert_equal(true,success)
  end
  test "can't get another user command product" do
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
    get "/api/users/1/commands/1/command_products"
    success = response.parsed_body["success"]
    assert_equal(false,success)
  end
  test "Admin can get another user command product" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/2/commands/4/command_products"
    success = response.parsed_body["succes"]
    assert_equal(true,success)
  end
  test "can search command with product ID" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/commands/1/command_products", params: {q: "10"}
    success = response.parsed_body["success"]
    command_products = response.parsed_body["command_products"]
    assert_equal(true,success)
    assert_equal(1,command_products.count)
  end
  test "can delete command ID" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    delete "/api/users/1/commands/1/command_products/1"
    success = response.parsed_body["succes"]
    assert_equal(true,success)
  end
  test " Admin can delete command ID from another user" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    delete "/api/users/2/commands/4/command_products/3"
    success = response.parsed_body["succes"]
    assert_equal(true,success)
  end
  test "normal user can't delete command ID from another user" do
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
    delete "/api/users/1/commands/1/command_products/1"
    success = response.parsed_body["success"]
    assert_equal(false,success)
  end

end
