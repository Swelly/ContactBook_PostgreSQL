require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'rainbow'

get '/' do
  puts "This is the index"
  erb :index
end

get '/contacts' do
  puts ": Database opened".color(:blue)
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "SELECT * FROM contacts"
  @contacts = db.exec(sql)
  puts ":: @contacts pulled from database".color(:yellow)
  db.close
  puts "::: Database now closed".color(:magenta)
  erb :contacts
end

get '/contact/new_contact' do
  erb :new_contact
end

post '/contacts' do

  first = params[:first]
  last = params[:last]
  age = params[:age]
  gender = params[:gender]
  dtgt = params[:dtgt]
  phone = params[:phone]

  sql = "INSERT INTO CONTACTS (first, last, age, gender, dtgt, phone) VALUES ('#{first}', '#{last}', #{age}, '#{gender}', '#{dtgt}', '#{phone}')"

  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  db.exec(sql)
  db.close
  redirect to('/contacts')
end

post '/contacts/delete' do
  "Concrete shoes"
  #Figure out who to delete
  #Write sql to delete them
  #Go someplace
end

get '/contacts/:id' do
  @id = params[:id]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "SELECT * from contacts WHERE id = #{@id}"
  @contact = db.exec(sql).first
  db.close
  erb :contact
end
