require 'test_helper'

class Api::MessagesControllerTest < ActionDispatch::IntegrationTest
  #index
  test "get all messages" do 
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/messages"
    messages = response.parsed_body
    assert_equal(6, messages.count)
    assert_response :success
  end

  #show
  test "get one message from user" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/messages/2"
    message = Message.new(response.parsed_body)
    assert_equal(Message.find(2), message)
    assert_response :success
  end
  
  test "can't get message if message doesn't exist" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    assert_raises(ActiveRecord::RecordNotFound) do
      get "/api/users/2/messages/7"
      assert_response :unprocessable_entity
    end
  end

  #create
  test "can create message" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/users/3/messages",
      params: {message: {texte: "Rails test", user_id: 3, conversation_id: 2}}
      message = Message.new(response.parsed_body)
      assert_equal(Message.last, message)
      assert_response :success
  end

  test "can't create message without texte" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/users/3/messages", params: {message: {texte: "", conversation_id: 2, user_id: 3}}
      assert_equal({"texte"=>["can't be blank"]}, response.parsed_body)
      assert_response :unprocessable_entity
  end
end
