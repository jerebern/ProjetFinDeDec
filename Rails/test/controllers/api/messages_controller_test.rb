require 'test_helper'

class Api::MessagesControllerTest < ActionDispatch::IntegrationTest
  #create
  test "can create message" do
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/users/3/messages",
      params: {message: {texte: "Rails test", user_id: 3, conversation_id: 2}}
      message = Message.new(response.parsed_body)
      assert_equal(Message.last, message)
      assert_response :success
  end
end
