require 'securerandom'
require_relative '../mixins/loggable'
require_relative '../templates/company_template'

module BuiltinRuby
  module UseCases
    module CreateCompany
      include BuiltinRuby::Mixins::Loggable

      BUILTINRUBY_REPOSITORY = ENV['BUILTINRUBY_REPOSITORY']
      BUILTINRUBY_BRANCH = ENV['BUILTINRUBY_BRANCH']

      class << self
        def call(params)
          logger.debug(params)

          params[:id] = SecureRandom.uuid
          params[:posted_at] = Date.today
          params[:title] = params[:company]

          slug = (params[:title] || '').downcase.strip.gsub(/\W/, '-').gsub(/\s+/, '-')
          content = BuiltinRuby::Templates::CompanyTemplate.render(params)

          github.create_contents(
            BUILTINRUBY_REPOSITORY,
            "companies/#{slug}.md",
            "[event] created new company `#{params[:id]} #{slug}`",
            content,
            branch: BUILTINRUBY_BRANCH
          )

          { id: params[:id] }
        end

        private

        def github
          Octokit::Client.new
        end
      end
    end
  end
end
