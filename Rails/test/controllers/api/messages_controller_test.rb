require 'test_helper'

class Api::MessagesControllerTest < ActionDispatch::IntegrationTest
  #index
  test "admin can get all messages" do 
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/messages"
    messages = response.parsed_body["messages"]
    assert_equal(6, messages.count)
    assert_response :success
  end

  test "not admin can't get all messages" do
    post "/users/sign_in", params: {user: {email: "felixcm1129@hotmail.ca", password: "123456"}}
    get "/api/users/1/messages"
    messages = response.parsed_body["messages"]
    assert_not_equal(6, messages.count)
    assert_response :success
  end

  #show
  test "get one message from user" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/messages/2"
    message = Message.new(response.parsed_body["message"])
    assert_equal(Message.find(2), message)
    assert_response :success
  end
  
  test "current user can't get message from other user should not be able to find it" do
    post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    assert_raises(ActiveRecord::RecordNotFound) do
      get "/api/users/1/messages/2"
      assert_equal(response.parsed_body["success"], false)
    end
  end

  test "can't get message if message doesn't exist" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    assert_raises(ActiveRecord::RecordNotFound) do
      get "/api/users/2/messages/7"
      assert_equal(false, response.parsed_body["success"])
    end
  end

  #create
  test "admin can create message" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/users/1/messages",
      params: {message: {texte: "Rails test", user_id: 1, conversation_id: 2}}
      message = Message.new(response.parsed_body["message"])
      assert_equal(Message.last, message)
      assert_response :success
  end

  test "normal user can create message" do
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
    post "/api/users/2/messages",
      params: {message: {texte: "Rails test", user_id: 2, conversation_id: 1}}
      message = Message.new(response.parsed_body["message"])
      assert_equal(Message.last, message)
      assert_response :success
  end

  test "can't create message without texte" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/users/1/messages", params: {message: {texte: "", conversation_id: 2, user_id: 3}}
      assert_equal({"success"=>false, "error"=>[{"texte"=>["can't be blank"]}]}, response.parsed_body)
      assert_response :success
  end

  #update
  test "admin can update his own messages" do 
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    patch "/api/users/1/messages/2", params: {message: {texte: "Hello"}}
    message = Message.new(response.parsed_body["message"])
    assert_equal(Message.find(2), message)
    assert_response :success
  end

  test "normal user can update his own messages" do 
    post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    patch "/api/users/3/messages/3", params: {message: {texte: "Hello"}}
    message = Message.new(response.parsed_body["message"])
    assert_equal(Message.find(3), message)
    assert_response :success
  end

  test "admin can't update messages from other users. Message shouldn't be found" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
      assert_raises(ActiveRecord::RecordNotFound) do
        patch "/api/users/3/messages/3", params: {message: {texte: "Hello"}}
        assert_equal(response.parsed_body["success"], false)
      end
    end

  test "normal user can't update messages from other users. Message shouldn't be found" do
  post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    assert_raises(ActiveRecord::RecordNotFound) do
      patch "/api/users/1/messages/2", params: {message: {texte: "Hello"}}
      assert_equal(response.parsed_body["success"], false)
    end
  end

  test "can't update if texte is blank" do 
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    patch "/api/users/1/messages/2", params: {message: {texte: ""}}
    message = Message.new(response.parsed_body["message"])
    assert_equal({"success"=>false, "error"=>[{"texte"=>["can't be blank"]}]}, response.parsed_body)
    assert_response :success
  end

  #delete
  test "admin can delete his own messages" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    assert_difference "Message.count", -1 do
      delete "/api/users/1/messages/2"
    end
  end

  test "normal user can delete his own messages" do
    post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    assert_difference "Message.count", -1 do
      delete "/api/users/3/messages/3"
    end
  end

  test "admin can't delete messages from other users. Message shouldn't be found" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    assert_raises(ActiveRecord::RecordNotFound) do
      delete "/api/users/3/messages/3"
      assert_equal(response.parsed_body["success"], false)
    end
  end

  test "normal user can't delete messages from other users. Message shouldn't be found" do
    post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    assert_raises(ActiveRecord::RecordNotFound) do
      delete "/api/users/1/messages/2"
      assert_equal(response.parsed_body["success"], false)
    end
  end

  test "can't delete non existant message" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    assert_raises(ActiveRecord::RecordNotFound) do
      delete "/api/users/1/messages/10"
      assert_equal(response.parsed_body["success"], false)
    end
  end  
end
