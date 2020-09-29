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
    def call(params)
      params[:id] = SecureRandom.uuid
      slug = params[:title].downcase.strip.gsub(/\W/, '-').gsub(/\s+/, '-')

      github.create_contents(
        BUILTINRUBY_REPOSITORY,
        "path/to/#{Date.today}-#{slug}.md",
        "[event] created new job `#{params[:id]} file`",
        Templates::Job.render(params),
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
  stash = {
    posted_at: Date.today,
    title: params[:title],
    company: params[:company],
    role: params[:role],
    level: params[:level],
    location: params[:location],
    employment_term: params[:employment_term],
    pay_rate: params[:pay_rate],
    website: params[:websile],
    tags: params[:tags],
    description: params[:description],
    requirements: params[:requirements],
    benefits: params[:benefits],
    how_to_apply: params[:how_to_apply],
  }

  result = CreateJob.call(stash)
  json id: result[:id], message: 'JOB_CREATED'
end

module Templates
  module Job
    class << self
      def render(params = {})
        %[
---
_id: #{params[:id]}
layout: jobs
posted_at: #{params[:posted_at]}
title: #{params[:title]}
company: #{params[:company]}
role: #{params[:role]}
level: #{params[:level]}
location: #{params[:location]}
employment_term: #{params[:employment_term]}
pay_rate: #{params[:pay_rate]}
website: #{params[:website]}
status: searching
tags:
  - #{params[:tags].join("\n  - ")}
---

## Descrição da Vaga
#{params[:description]}

## Requisitos
#{params[:requirements]}

## Benefícios
#{params[:benefits]}

## Como se candidatar?
#{params[:how_to_apply]}
        ]
      end
    end
  end
end
