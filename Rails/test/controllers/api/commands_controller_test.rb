require 'test_helper'

class Api::CommandsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can list commands" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/commands"
    commands = response.parsed_body["commands"]
    success = response.parsed_body["success"]
    assert_equal(3,commands.count)
    assert_equal(true,success)
  end
  test "can get one command" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/commands/1"
   success = response.parsed_body["success"]
    assert_equal(true,success)
  end
  test "can't get command doesnt belong to this user " do
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}

    get "/api/commands/2"
    success = response.parsed_body["success"]
    assert_equal(false,success)

  end
  test "can't delete command doesnt belong to this user " do
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
      delete "/api/commands/1"
      success = response.parsed_body["success"]
      assert_equal(false,success)

    end
  test "can delete command " do
      post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
        delete "/api/commands/1"
        success = response.parsed_body["success"]
        assert_equal(true,success)
  
    end  
   test "Can search command " do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/commands", params: {q: "Payé"}
    commands = response.parsed_body["commands"]
    assert_equal(2,commands.count)
    success = response.parsed_body["success"]
    assert_equal(true,success)
   end
   test "Send invalid search querry for command should return 0 " do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/commands", params: {q: "ABCDEFEID"}
    commands = response.parsed_body["commands"]
    assert_equal(0,commands.count)
    success = response.parsed_body["success"]
    assert_equal(true,success)
   end
   
  test "can update one command " do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    patch "/api/commands/1", params: {command: {shipping_adress: "TEST1233455"}}
    success = response.parsed_body["success"]
    assert_equal(true,success)
    
  end
  test "can create a estimated command but doesnt save in database " do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/commands", params:{sendCommand: false}
    success = response.parsed_body["success"]
    assert_equal(true,success)
    
  end
  test "can create a command" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/commands"
    success = response.parsed_body["success"]
    command = Command.new(response.parsed_body["command"])
    assert_equal(true,success)
  end

  

end
