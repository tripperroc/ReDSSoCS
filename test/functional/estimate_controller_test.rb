require 'test_helper'

class EstimateControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
