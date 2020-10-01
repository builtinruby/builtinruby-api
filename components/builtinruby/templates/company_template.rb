module BuiltinRuby
  module Templates
    module CompanyTemplate
      class << self
        def render(params = {})
          %[---
_id: #{params['id']}
layout: companies
posted_at: #{params['posted_at']}
title: #{params['title']}
category: #{params['category']}
founded_at: #{params['founded_at']}
logo: #{params['logo']}
location: #{params['location']}
website: #{params['website']}
blog: #{params['blog']}
github: #{params['github']}
linkedin: #{params['linkedin']}
---

#{params['description']}
          ]
        end
      end
    end
  end
end
