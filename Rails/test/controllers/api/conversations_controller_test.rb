require 'test_helper'

class Api::ConversationsControllerTest < ActionDispatch::IntegrationTest
  #index
  test "get all conversations" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/conversations"
    conversations = response.parsed_body["conversations"]
    assert_equal(3, conversations.count)
    assert_response :success
  end

  test "if current_user_is_not_admin should return nil" do
    post "/users/sign_in", params: {user: {email: "felixcm1129@hotmail.ca", password: "123456"}}
    get "/api/conversations"
    conversations = response.parsed_body["conversations"]
    assert_nil(conversations)
    assert_response :success
  end

  test "can search conversations" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/conversations", params:{q: "T@Titre"}
    conversations = response.parsed_body["conversations"]
    assert_equal(3, conversations.count)
    success = response.parsed_body["success"]
    assert_equal(true, success)
  end

  test "if invalid search conversations should return zero conversations" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/conversations", params:{q: "B@Titre"}
    conversations = response.parsed_body["conversations"]
    assert_equal(0, conversations.count)
    success = response.parsed_body["success"]
    assert_equal(true, success)
  end


  #show
  test "get conversation from one user" do 
    post "/users/sign_in", params: {user: {email: "felixcm1129@hotmail.ca", password: "123456"}}
    get "/api/conversations/3"
    conversation = response.parsed_body["conversation"]
    assert_equal(1, conversation.count)
  end

  test "can't get conversation if user doesn't have any should return nil" do
    post "/users/sign_in", params: {user: {email: "johnDoe@hotmail.ca", password: "123456"}}
    get "/api/conversations"
    assert_nil(response.parsed_body["success"])
  end

  #create
  test "normal user can create conversation if he doesn't have any" do
    post "/users/sign_in", params: {user: {email: "johnDoe@hotmail.ca", password: "123456"}}
    post "/api/conversations", params: {conversation: {title: "Rails test", description: "Conversation créer dans Rails Test", email_user: "jevei@hotmail.com", user_id: 3}}
      conversations = Conversation.new(response.parsed_body["conversation"])
      assert_equal(Conversation.last, conversations)
      assert_response :success
  end

  test "normal user can't have more than one conversation" do
    post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    assert_difference "Conversation.count", 0 do
      post "/api/conversations", params: {conversation: {title: "Rails test", description: "Conversation créer dans Rails Test", email_user: "jevei@hotmail.com", user_id: 3}}
        conversations = Conversation.new(response.parsed_body["conversation"])
        assert_response :success
    end
  end

  test "can't create conversation without title" do
    post "/users/sign_in", params: {user: {email: "johnDoe@hotmail.ca", password: "123456"}}
    post "/api/conversations", params: {conversation: {title: "", description: "Conversation créer dans Rails Test", email_user: "jevei@hotmail.com", user_id: 3}}
      assert_equal({"success"=>false, "error"=>[{"title"=>["can't be blank"]}]}, response.parsed_body)
      assert_equal(false, response.parsed_body["success"])
  end

  test "can't create conversation without description" do
    post "/users/sign_in", params: {user: {email: "johnDoe@hotmail.ca", password: "123456"}}
    post "/api/conversations", params: {conversation: {title: "Rails Test", description: "", email_user: "jevei@hotmail.com", user_id: 3}}
      assert_equal({"success"=>false, "error"=>[{"description"=>["can't be blank"]}]}, response.parsed_body)
      assert_equal(false, response.parsed_body["success"])
  end

  #update
  test "current_user can update is own conversation" do
    post "/users/sign_in", params: {user: {email: "felixcm1129@hotmail.ca", password: "123456"}}
    patch "/api/conversations/3", params: {conversation: {title: "Hello Rails Test"}}
    conversation = Conversation.new(response.parsed_body["conversation"])
    assert_equal(Conversation.find(3), conversation)
    assert_response :success
  end

  test "current_user can't update other conversation should not find conversation" do
    post "/users/sign_in", params: {user: {email: "felixcm1129@hotmail.ca", password: "123456"}}
    assert_raises(ActiveRecord::RecordNotFound) do
      patch "/api/conversations/2", params: {conversation: {title: "Hello Rails Test"}}
      conversation = Conversation.new(response.parsed_body["conversation"])
    end
  end

  test "can't update conversation if title is blank" do 
    post "/users/sign_in", params: {user: {email: "felixcm1129@hotmail.ca", password: "123456"}}
    patch "/api/conversations/3", params: {conversation: {title: ""}}
    conversation = Conversation.new(response.parsed_body["conversation"])
    assert_equal({"success"=>false, "error"=>[{"title"=>["can't be blank"]}]}, response.parsed_body)
    assert_response :success
  end

  test "can't update conversation if description is blank" do 
    post "/users/sign_in", params: {user: {email: "felixcm1129@hotmail.ca", password: "123456"}}
    patch "/api/conversations/3", params: {conversation: {description: ""}}
    conversation = Conversation.new(response.parsed_body["conversation"])
    assert_equal({"success"=>false, "error"=>[{"description"=>["can't be blank"]}]}, response.parsed_body)
    assert_response :success
  end

  #delete
  test "admin can delete conversation should delete all messages from that conversation" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    assert_difference "Conversation.count", -1 do
      delete "/api/conversations/2"
    end
  end

  test "normal user can't delete conversation" do
    post "/users/sign_in", params: {user: {email: "felixcm1129@hotmail.ca", password: "123456"}}
    assert_difference "Conversation.count", 0 do
      delete "/api/conversations/3"
      assert_nil(response.parsed_body["success"])
    end
  end
end
