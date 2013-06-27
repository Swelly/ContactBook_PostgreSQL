require 'pg'
require 'pry'

puts "Hey gurl"

#establishes connection to database (must be a hash)
# db = PG.connect(
#   :dbname => 'address_book',
#   :host => 'localhost')
# #passes in a string of sql & executes ( 'exec()' )
# # Reads from database
# sql = "select first, last, age, gender, dtgd, phone"
# db.exec(sql) do |result|
#   result.each do |row|
#     binding.pry
#   end
# end
# ^ selects all(*) from contacts in address_book database
# db.close

puts "What's your first name?"
first = gets.chomp
puts "And your last name is...?"
last = gets.chomp
puts "How old are you?"
age = gets.chomp.to_i
puts "What's your gender?"
gender = gets.chomp
puts "Are you down to get down?"
dtgd = gets.chomp
puts "Uhh sweet... phone number?"
phone = gets.chomp

db = PG.connect( :dbname => 'address_book', :host => 'localhost')
sql = "insert into contacts (first, last, age, gender, dtgd, phone)
  values ('#{first}', '#{last}', #{age}, '#{gender}', #{dtgd}, '#{phone}')"

db.exec(sql)
db.close
