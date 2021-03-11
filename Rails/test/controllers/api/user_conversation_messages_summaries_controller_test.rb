require "test_helper"

class UserConversationMessagesSummariesControllerTest < ActionDispatch::IntegrationTest

  #index
  test "test can get user conversation messages summary report for all users " do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/user_conversation_messages_summaries/", params:{s: ""}
    summary = response.parsed_body["user_conversation_messages_summary"]
    assert_equal(3, summary.count)
  end
  
  test "test can't get user conversation messages summary when not admin  " do
    User.find(2).picture.attach(io: File.open(Rails.root + "app/assets/images/default.jpg"), filename: 'default.jpg')
    post "/users/sign_in", params: {user: {email: "jere.bern@hotmail.com", password: "123456"}}
    get "/api/user_conversation_messages_summaries/", params:{s: ""}
    success = response.parsed_body["success"]
    error = response.parsed_body["error"]
    assert_equal("not admin",error)
    assert_equal(false,success)
  end

  test "test can do a sort" do
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/user_conversation_messages_summaries/", params:{s: "fullnameDown"}
    summary = response.parsed_body["user_conversation_messages_summary"]
    assert_equal(3, summary.count)
  end

  test "test can do search by title" do 
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/user_conversation_messages_summaries/", params:{q: "Titre(*)Test1"}
    summary = response.parsed_body["user_conversation_messages_summary"]
    assert_equal(1, summary.count)
    success = response.parsed_body["success"]
    assert_equal(true, success)
  end

  test "test can do search by name" do 
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/user_conversation_messages_summaries/", params:{q: "Nom(*)Félix"}
    summary = response.parsed_body["user_conversation_messages_summary"]
    assert_equal(1, summary.count)
    success = response.parsed_body["success"]
    assert_equal(true, success)
  end

  test "test can do search by email" do 
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/user_conversation_messages_summaries/", params:{q: "Email(*)jere.bern@hotmail.com"}
    summary = response.parsed_body["user_conversation_messages_summary"]
    assert_equal(1, summary.count)
    success = response.parsed_body["success"]
    assert_equal(true, success)
  end

  test "test blank search will return 0 summaries" do 
    User.find(1).picture.attach(io: File.open(Rails.root + "app/assets/images/giraffe.png"), filename: 'giraffe.png')
    post "/users/sign_in", params: {user: {email: "admin@jfj.com", password: "123456"}}
    get "/api/user_conversation_messages_summaries/", params:{q: "Email(*) "}
    summary = response.parsed_body["user_conversation_messages_summary"]
    assert_equal(0, summary.count)
    success = response.parsed_body["success"]
    assert_equal(true, success)
  end

end
