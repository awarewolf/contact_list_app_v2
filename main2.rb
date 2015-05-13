require './contact'
require 'pry'

contact = Contact.new("Khurram", "Virani", "kv@gmail.com")

contact.save

contact.firstname = "K"
contact.lastname = "V"
contact.save

id = contact.id

num1 = PhoneNumber.new(id,'604-555-5555')
num1.save

num2 = PhoneNumber.new(id,'604-666-6666','Number of the B3457')
num2.save
# binding.pry
puts PhoneNumber.find_all_for(id)

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