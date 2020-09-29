require 'date'
require 'sinatra'
require 'octokit'
require 'sinatra/json'
require 'securerandom'

OCTOKIT_TOKEN = ENV['OCTOKIT_TOKEN']
BUILTINRUBY_REPOSITORY = ENV['BUILTINRUBY_REPOSITORY']
BUILTINRUBY_BRANCH = ENV['BUILTINRUBY_BRANCH']

configure do
  enable(:logging)

  set :repository, BUILTINRUBY_REPOSITORY

  set :branch, BUILTINRUBY_BRANCH
end

def github
  Octokit::Client.new(access_token: OCTOKIT_TOKEN)
end

module CreateJob
  class << self
    def call
      id = SecureRandom.uuid

      github.create_contents(
        BUILTINRUBY_REPOSITORY,
        "path/to/#{Date.today}-#{id}file.md",
        "[event] created new job `#{id} file`",
        'The File Content',
        branch: BUILTINRUBY_BRANCH
      )

      { id: id }
    end
  end
end

get '/' do
  json message: 'Welcomme to BuiltinRuby.com'
end

post '/jobs' do
  result = CreateJob.call
  json id: result[:id], message: 'JOB_CREATED'
end
