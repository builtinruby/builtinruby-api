module BuiltinRuby
  module Templates
    module JobTemplate
      class << self
        def render(params = {})
          %[---
_id: #{params['id']}
layout: jobs
posted_at: #{params['posted_at']}
title: #{params['title']}
company: #{params['company']}
role: #{params['role']}
level: #{params['level']}
location: #{params['location']}
employment_term: #{params['employment_term']}
pay_rate: #{params['pay_rate']}
website: #{params['website']}
status: searching
tags:
  - #{(params['tags'] || []).join("\n  - ")}
---

## Descrição da Vaga
#{params['description']}

## Requisitos
#{params['requirements']}

## Benefícios
#{params['benefits']}

## Como se candidatar?
#{params['how_to_apply']}
          ]
        end
      end
    end
  end
end
