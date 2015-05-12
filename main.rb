require './contact'
require 'pry'

contact = Contact.new("Khurram", "Virani", "kv@gmail.com")
contact.save

contact.firstname = "K"
contact.lastname = "V"
contact.save

id = contact.id

same_contact = Contact.find(id)
puts same_contact.firstname # => 'K'
puts same_contact.lastname  # => 'V'
puts same_contact.email # => 'kv@gmail.com'

contacts = Contact.find_all_by_lastname('Virani')
contacts.each do |c|
  puts c
end

same_contact.destroy

puts Contact.find(id).inspect