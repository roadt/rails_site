require 'test_helper'

class TestControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get env" do
    get :env
    assert_response :success
  end

end
