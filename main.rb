require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'rainbow'

get '/' do
  erb :index
end

get '/contacts' do
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "SELECT * FROM contacts"
  @contacts = db.exec(sql)
  erb :contacts
end

get '/contacts/:name' do
  @first_name = params[:name]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "SELECT * from contacts WHERE first = '#{@first_name}'"
  @contact = db.exec(sql).first
  db.close
  erb :contact
end
