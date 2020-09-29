require 'sinatra'
require 'sinatra/json'

get '/' do
  json message: 'Welcomme to BuiltinRuby.com'
end
