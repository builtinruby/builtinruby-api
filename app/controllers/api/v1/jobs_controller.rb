require_relative Rails.root.join('components', 'builtinruby', 'use_cases', 'create_job')

module API
  module V1
    class JobsController < ApplicationController
      def create
        result = BuiltinRuby::UseCases::CreateJob.call(params)

        render json: { id: result[:id], message: 'JOB_CREATED' }
      end
    end
  end
end
