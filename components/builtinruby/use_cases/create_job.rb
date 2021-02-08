require 'securerandom'
require_relative '../mixins/loggable'
require_relative '../templates/job_template'

module BuiltinRuby
  module UseCases
    module CreateJob
      include BuiltinRuby::Mixins::Loggable

      BUILTINRUBY_REPOSITORY = ENV['BUILTINRUBY_REPOSITORY']
      BUILTINRUBY_BRANCH = ENV['BUILTINRUBY_BRANCH']

      class << self
        def call(params)
          logger.debug(params)

          params[:id] = SecureRandom.uuid
          params[:posted_at] = Date.today
          params[:title] = "#{params[:role]} na #{params[:company]}"

          slug = (params[:title] || '').downcase.strip.gsub(/\W/, '-').gsub(/\s+/, '-')
          content = BuiltinRuby::Templates::JobTemplate.render(params)

          github.create_contents(
            BUILTINRUBY_REPOSITORY,
            "_jobs/#{params[:posted_at]}-#{slug}.md",
            "[event] created new job `#{params[:id]} #{slug}`",
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
