require 'test_helper'

class Api::V1::JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_jobs_create_url
    assert_response :success
  end

end
