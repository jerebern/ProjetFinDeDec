require 'test_helper'

class Api::ConversationsControllerTest < ActionDispatch::IntegrationTest
  #index
  test "get all conversations" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/conversations"
    assert_response :success
  end

  #show
  test "get conversation user" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/2/conversations/3"
    assert_response :success
  end

  test "can't get conversation if wrong user" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/1/conversations/3"
    assert_response :unprocessable_entity
  end
  
  test "can't get conversation if conversation doesn't exist" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/users/2/conversations/7"
    assert_response :unprocessable_entity
  end

  #create
  test "can create conversation" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/users/3/conversations",
      params: {conversations: {title: "Rails test", description: "Conversation créer dans Rails Test", user_id: 3}}
      conversations = Conversation.new(response.parsed_body)
      assert_equal(Conversation.last, conversations)
      assert_response :success
  end

  test "can't create conversation without title" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/users/3/conversations",
      params: {conversation: {title: "", description: "Conversation créer dans Rails Test", user_id: 3}}
      assert_equal({"title"=>["can't be blank"]}, response.parsed_body)
      assert_response :success
  end

  test "can't create conversation without description" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/users/3/conversations",
      params: {conversation: {title: "Rails Test", description: "", user_id: 3}}
      assert_equal({"description"=>["can't be blank"]}, response.parsed_body)
      assert_response :success
  end

  #update

  #delete
end
