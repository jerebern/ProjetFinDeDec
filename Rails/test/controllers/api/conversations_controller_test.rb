require 'test_helper'

class Api::ConversationsControllerTest < ActionDispatch::IntegrationTest
  #index
  test "get all conversations" do
    @conversations = get "/api/users/1/conversations"
    assert_equal 3, @conversations.count
  end
  test "can't get all conversations if user doesn't exist" do
    get "/api/users/9/conversations"
    assert_response :unprocessable_entity
  end

  #show
  test "get conversation user" do
    get "/api/users/2/conversations/3"
    assert_response :success
  end
  test "can't get conversation if wrong user" do
    get "/api/users/1/conversations/3"
    assert_response :unprocessable_entity
  end
  test "can't get conversation if conversation doesn't exist" do
    get "/api/users/2/conversations/7"
    assert_response :unprocessable_entity
  end

  #create
  test "can create conversation" do
    post "/api/users/3/conversations",
      params: {conversation: {title: "Rails test", description: "Conversation créer dans Rails Test", user_id: 3}}
      conversation = Conversation.new(response.parsed_body)
      assert_equal(Conversation.last, conversation)
      assert_response :success
  end

  test "can't create conversation without title" do
    post "/api/users/3/conversations",
      params: {conversation: {title: "", description: "Conversation créer dans Rails Test", user_id: 3}}
      assert_equal({"title"=>["can't be blank"]}, response.parsed_body)
      assert_response :success
  end

  test "can't create conversation without description" do
    post "/api/users/3/conversations",
      params: {conversation: {title: "Rails Test", description: "", user_id: 3}}
      assert_equal({"description"=>["can't be blank"]}, response.parsed_body)
      assert_response :success
  end
  
  #update

  #delete
end
