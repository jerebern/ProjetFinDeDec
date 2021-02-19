require 'test_helper'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "Can get User" do 
    get "/api/users/1"
    assert_response :success
  end
end
