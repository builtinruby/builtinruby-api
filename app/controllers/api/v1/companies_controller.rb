require_relative Rails.root.join('components', 'builtinruby', 'use_cases', 'create_company')

module API
  module V1
    class CompaniesController < ApplicationController
      def create
        result = BuiltinRuby::UseCases::CreateCompany.call(params)

        render json: { id: result[:id], message: 'COMPANY_CREATED' }
      end
    end
  end
end
