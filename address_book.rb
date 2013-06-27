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

db = PG.connect( :dbname => 'address_book', :host => 'localhost')

sql = "insert into contacts (first, last, age, gender, dtgd, phone)
  values ('ben', 'israeli', 26, 'm', 'true', '310-923-2319')"

db.exec(sql)
db.close
