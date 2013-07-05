require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'rainbow'

# helpers do
#   def open_db
#     PG.connect(:dbname => 'address_book', :host => 'localhost')
#   end
# end

#run sql database
def run_sql(sql)
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  #result = db.exec(sql)
  db.close
  #Return whatever needs to happen now
end

#Show index page
get '/' do
  puts "This is the index"
  erb :index
end

# Retrieve contacts from database
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

#Go to form to create new contact
get '/contact/new_contact' do
  erb :new_contact
end

#Post the new contact to database
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

#Get contact to edit
get '/contacts/:id/edit' do
  id = params[:id]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "SELECT * FROM contacts WHERE id = #{id}"
  @contact = db.exec(sql).first
  db.close
  erb :edit
end

#Update specific id in database
post '/contacts/:id' do

  id = params[:id]
  first = params[:first]
  last = params[:last]
  age = params[:age]
  gender = params[:gender]
  dtgt = params[:dtgt]
  phone = params[:phone]

  db = PG.connect(:dbname => 'address_book', :host => 'localhost')

  #telling sql to update the specific ID(contact) with all changed form values
  sql = "UPDATE contacts SET (first, last, age, gender, dtgt, phone) = ('#{first}', '#{last}', '#{age}', '#{gender}', '#{dtgt}', '#{phone}') WHERE id = #{id}"

  db.exec(sql)
  db.close
  redirect to('/contacts')
end

post '/contacts/:id/delete' do
  @id = params[:id]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "DELETE FROM contacts WHERE id = #{@id}"
  db.exec(sql)
  db.close
  redirect to "/contacts"
end
#Get contacts
get '/contacts/:id' do
  @id = params[:id]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "SELECT * from contacts WHERE id = #{@id}"
  @contact = db.exec(sql).first
  db.close
  erb :contact
end
