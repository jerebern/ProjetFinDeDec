require 'test_helper'

class Api::MessagesControllerTest < ActionDispatch::IntegrationTest
  #index
  test "admin can get all messages" do 
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/messages"
    messages = response.parsed_body["messages"]
    assert_equal(6, messages.count)
    assert_response :success
  end

  test "not admin can't get all messages" do
    User.find(4).picture.attach(io: File.open(Rails.root + "app/assets/images/snoopy.jpg"), filename: 'snoopy.jpg')
    post "/users/sign_in", params: {user: {email: "felixcm1129@hotmail.ca", password: "123456"}}
    get "/api/messages"
    messages = response.parsed_body["messages"]
    assert_not_equal(6, messages.count)
    assert_response :success
  end

  test "can search messages" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/messages", params:{q: "A"}
    messages = response.parsed_body["messages"]
    assert_equal(6, messages.count)
    success = response.parsed_body["success"]
    assert_equal(true, success)
  end

  test "if invalid search messages should return zero messages" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/messages", params:{q: "F"}
    messages = response.parsed_body["messages"]
    assert_equal(0, messages.count)
    success = response.parsed_body["success"]
    assert_equal(true, success)
  end

  #show
  test "get one message from user" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/messages/2"
    message = Message.new(response.parsed_body["message"])
    assert_equal(Message.find(2), message)
    assert_response :success
  end
  
  test "current user can't get message from other user should not be able to find it" do
    User.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/canarie.JPG"), filename: 'canarie.JPG')
    post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    get "/api/messages/2"
    assert_equal(false, response.parsed_body["success"])
  end

  test "can't get message if message doesn't exist" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/messages/7"
    assert_equal(false, response.parsed_body["success"])
  end

  #create
  test "admin can create message" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/messages",
      params: {message: {body: "Rails test", user_id: 1, conversation_id: 2}}
      message = Message.new(response.parsed_body["message"])
      assert_equal(Message.last, message)
      assert_response :success
  end

  test "normal user can create message" do
    User.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/default.jpg"), filename: 'default.jpg')
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
    post "/api/messages",
      params: {message: {body: "Rails test", user_id: 2, conversation_id: 1}}
      message = Message.new(response.parsed_body["message"])
      assert_equal(Message.last, message)
      assert_response :success
  end

  test "can't create message without body" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    post "/api/messages", params: {message: {body: "", conversation_id: 2, user_id: 3}}
      assert_equal({"success"=>false, "error"=>[{"body"=>["can't be blank"]}]}, response.parsed_body)
      assert_response :success
  end

  #update
  test "admin can update his own messages" do 
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    patch "/api/messages/2", params: {message: {body: "Hello"}}
    message = Message.new(response.parsed_body["message"])
    assert_equal(Message.find(2), message)
    assert_response :success
  end

  test "normal user can update his own messages" do 
    User.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/canarie.JPG"), filename: 'canarie.JPG')
    post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    patch "/api/messages/3", params: {message: {body: "Hello"}}
    message = Message.new(response.parsed_body["message"])
    assert_equal(Message.find(3), message)
    assert_response :success
  end

  test "admin can't update messages from other users. Message shouldn't be found" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
      patch "/api/messages/3", params: {message: {body: "Hello"}}
      assert_equal(false, response.parsed_body["success"])
    end

  test "normal user can't update messages from other users. Message shouldn't be found" do
    User.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/canarie.JPG"), filename: 'canarie.JPG')
  post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    patch "/api/messages/2", params: {message: {body: "Hello"}}
    assert_equal(false, response.parsed_body["success"])
  end

  test "can't update if body is blank" do 
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    patch "/api/messages/2", params: {message: {body: ""}}
    message = Message.new(response.parsed_body["message"])
    assert_equal({"success"=>false, "error"=>[{"body"=>["can't be blank"]}]}, response.parsed_body)
    assert_response :success
  end

  #delete
  test "admin can delete his own messages" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    assert_difference "Message.count", -1 do
      delete "/api/messages/2"
    end
  end

  test "normal user can delete his own messages" do
    User.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/canarie.JPG"), filename: 'canarie.JPG')
    post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    assert_difference "Message.count", -1 do
      delete "/api/messages/3"
    end
  end

  test "admin can't delete messages from other users. Message shouldn't be found" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    delete "/api/messages/3"
    assert_equal(false, response.parsed_body["success"])
  end

  test "normal user can't delete messages from other users. Message shouldn't be found" do
    User.find(3).picture.attach(io: File.open(Rails.root + "app/assets/images/canarie.JPG"), filename: 'canarie.JPG')
    post "/users/sign_in", params: {user: {email: "jevei@hotmail.com", password: "123456"}}
    delete "/api/messages/2"
    assert_equal(false, response.parsed_body["success"])
  end

  test "can't delete non existant message" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    delete "/api/messages/10"
    assert_equal(false, response.parsed_body["success"])
  end  
end
