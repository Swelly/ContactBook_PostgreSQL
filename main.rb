require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'rainbow'

get '/' do
  erb :index
end

get '/contacts' do
  "Contacts should go here"
end
