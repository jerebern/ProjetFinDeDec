require 'test_helper'

class Api::CommandsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can list commands" do
    get "/api/users/1/commands"
    assert_response :success
  end
  test "can get one command" do
   get "/api/users/1/commands/1"
   assert_response :success
  end
  test "can't get command doesnt belong to this user " do
  assert_raises(ActiveRecord::RecordNotFound) do
    get "/api/users/1/commands/2"
  end
  end

end
