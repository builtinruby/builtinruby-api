require 'test_helper'
require_relative Rails.root.join('components', 'builtinruby', 'use_cases', 'create_job')

class API::V1::JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    ::BuiltinRuby::UseCases::CreateJob.stubs(:call).returns({id: 1})

    params = {}
    post api_v1_jobs_url(params)
    assert_response :success
  end

end
