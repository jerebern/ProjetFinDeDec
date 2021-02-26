require 'test_helper'

class Api::CommandsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can list commands" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/commands"
    assert_response :success
  end
  test "can get one command" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
   get "/api/users/1/commands/1"
   assert_response :success
  end
  test "can't get command doesnt belong to this user " do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
  assert_raises(ActiveRecord::RecordNotFound) do
    get "/api/users/1/commands/2"
  end
  end
  test "can't delete command doesnt belong to this user " do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    assert_raises(ActiveRecord::RecordNotFound) do
      delete "/api/users/1/commands/2"
    end
    end
  test "can update one command " do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    patch "/api/users/1/commands/1", params: {command: {shipping_adress: "TEST1233455"}}
    command = Command.find(1)
    assert_equal("TEST1233455", command.shipping_adress)
    assert_response :success
  end

end
