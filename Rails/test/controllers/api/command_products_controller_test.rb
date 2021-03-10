require "test_helper"

class Api::CommandProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can get command product" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/commands/1/command_products"
    success = response.parsed_body["succes"]
    assert_equal(true,success)
  end
  test "can't get another user command product" do
    User.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/default.jpg"), filename: 'default.jpg')
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
    get "/api/commands/1/command_products"
    success = response.parsed_body["success"]
    assert_equal(false,success)
  end

  test "can search command with product ID" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/commands/1/command_products", params: {q: "10"}
    success = response.parsed_body["success"]
    command_products = response.parsed_body["command_products"]
    assert_equal(true,success)
    assert_equal(1,command_products.count)
  end
  test "can delete command ID" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    delete "/api/commands/1/command_products/1"
    success = response.parsed_body["succes"]
    assert_equal(true,success)
  end

  test "normal user can't delete command ID from another user" do
    User.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/default.jpg"), filename: 'default.jpg')
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
    delete "/api/commands/1/command_products/1"
    success = response.parsed_body["success"]
    assert_equal(false,success)
  end

end
