require 'test_helper'

class Api::V1::CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_companies_create_url
    assert_response :success
  end

end
