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

*******

  def initialize
    ARGV << 'help' if ARGV.empty?
    @command = ARGV.shift.downcase
    @parameters = ARGV
    parse
  end

  def help
    puts "Here is a list of available commands:"
    puts "  new  - Create a new contact"
    puts "  list - List all contacts"
    puts "  show - Show a contact"
    puts "  find - Find a contact"
  end

  def get_info
    puts "Enter new contact info:"
    puts "email >"
    email = gets.chomp
    puts "first name >"
    firstname = gets.chomp
    puts "last name >"
    lastname = gets.chomp
    {email:email,firstname:name,lastname:name}
  end

  def create_new
    info = get_info
    Contact.new(info[:lastname], info[:firstname], info[:email])
  end

  def parse
    case @command
    when 'new'
      create_new
    when 'list'
      Contact.all
    when 'show'
      Contact.show(@parameters[1])
    when 'find'
      Contact.find(@parameters[1])
    when 'help'
      help
    else
      help
    end
  end

end