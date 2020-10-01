module API
  module V1
    class HomeController < ApplicationController
      def index
        render json: { message: 'Wellcome =)' }
      end
    end
  end
end
