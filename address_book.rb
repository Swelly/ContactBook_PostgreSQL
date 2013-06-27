require 'pg'
require 'pry'

puts "Hey gurl"

#establishes connection to database (must be a hash)
db = PG.connect(
  :dbname => 'address_book',
  :host => 'localhost'
  )
#passes in a string of sql & executes ( 'exec()' )
# Dealing with the response from the database
db.exec("select * from contacts") do |result|
  result.each do |row|
    binding.pry
  end
end
# ^ selects all(*) from contacts in address_book database
