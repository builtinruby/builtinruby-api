require 'test_helper'
require_relative Rails.root.join('components', 'builtinruby', 'use_cases', 'create_company')

class API::V1::CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    ::BuiltinRuby::UseCases::CreateCompany.stubs(:call).returns({id: 1})

    post api_v1_companies_url
    assert_response :success
  end

end
