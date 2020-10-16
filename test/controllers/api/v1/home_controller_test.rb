require 'test_helper'

class API::V1::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_root_url
    assert_response :success
  end

end
