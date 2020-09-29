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

module UseCases
  module CreateCompany
    class << self
      def call(params)
        params[:id] = SecureRandom.uuid
        params[:posted_at] = Date.today

        slug = params[:title].downcase.strip.gsub(/\W/, '-').gsub(/\s+/, '-')
        content = Templates::Company.render(params)

        github.create_contents(
          BUILTINRUBY_REPOSITORY,
          "companies/#{slug}.md",
          "[event] created new company `#{params[:id]} #{slug}`",
          content,
          branch: BUILTINRUBY_BRANCH
        )

        { id: id }
      end
    end
  end

  module CreateJob
    class << self
      def call(params)
        params[:id] = SecureRandom.uuid
        params[:posted_at] = Date.today

        slug = params[:title].downcase.strip.gsub(/\W/, '-').gsub(/\s+/, '-')
        content = Templates::Job.render(params)

        github.create_contents(
          BUILTINRUBY_REPOSITORY,
          "jobs/#{params[:posted_at]}-#{slug}.md",
          "[event] created new job `#{params[:id]} #{slug}`",
          content,
          branch: BUILTINRUBY_BRANCH
        )

        { id: id }
      end
    end
  end
end

get '/' do
  json message: 'Welcomme to BuiltinRuby.com'
end

post '/jobs' do
  job_params = params.slice(
    :title, :company, :role, :level, :location, :employment_term, :pay_rate, :website, :tags, :description,
    :requirements, :benefits, :how_to_apply
  )

  result = UseCases::CreateJob.call(job_params)
  json id: result[:id], message: 'JOB_CREATED'
end

post '/companies' do
  company_params = params.slice(
    :title, :category, :founded_at, :logo, :location, :website, :blog, :github, :linkedin, :description
  )

  result = UseCases::CreateCompany.call(company_params)
  json id: result[:id], message: 'COMPANY_CREATED'
end

module Templates
  module Company
    class << self
      %[---
_id: #{params[:id]}
layout: companies
posted_at: #{params[:posted_at]}
title: #{params[:title]}
category: #{params[:category]}
founded_at: #{params[:founded_at]}
logo: #{params[:logo]}
location: #{params[:location]}
website: #{params[:website]}
blog: #{params[:blog]}
github: #{params[:github]}
linkedin: #{params[:linkedin]}
---

#{params[:description]}
      ]
    end
  end

  module Job
    class << self
      def render(params = {})
        %[---
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
