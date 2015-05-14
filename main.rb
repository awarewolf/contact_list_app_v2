require './contact'
require 'pry'
require 'pp'
require 'colorize'

class Main

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

  def phone_number_prompt
    puts "Enter phone number:"
    prompt
    phone_number = STDIN.gets.chomp
    puts "Enter location ([return] for none):"
    prompt
    location = STDIN.gets.chomp
    location = nil if location.empty?
    PhoneNumber.new( @contact_id, phone_number, location )
  end

  def delete_prompt
    puts "Are you sure you want to delete this contact? (y/n)"
    prompt
    option = STDIN.gets.chomp.downcase
    case option
    when 'y'
      @contact.destroy
    when 'n'
    else
      invalid_option
      phone_number_prompt
    end
  end

   def more_options_prompt
    @contact.to_s
    puts "Contact options:"
    puts "(a)dd a phone number / (d)elete the contact / [return] to exit"
    prompt
    option = STDIN.gets.chomp.downcase
    case option
    when 'a'
      phone_number_prompt
    when 'd'
      delete_prompt
    when ''
    else
      invalid_option
      more_options_prompt
    end
  end

  def get_info
    puts "Enter new contact info:"
    print "first name >"
    firstname = STDIN.gets.chomp
    print "last name >"
    lastname = STDIN.gets.chomp
    print "email >"
    email = STDIN.gets.chomp
    { firstname: firstname, lastname: lastname, email: email }
  end

  def create_new
    info = get_info
    Contact.new( info[:firstname], info[:lastname], info[:email] )
  end

  def show_prompt
    puts "Show contacts by:"
    puts "(f)irst name, (l)astname, (e)mail"
    prompt
    option = STDIN.gets.chomp.downcase
    case option
    when 'f'
      Contact.find_all_by_firstname.inspect
    when 'l'
      Contact.find_all_by_lastname.inspect
    when 'e'
      Contact.find_all_by_email.inspect
    else
      invalid_option
      show_prompt
    end
  end

  def prompt
    print '>'
  end

  def invalid_option
    puts 'Invalid option'
  end

  def parse
    case @command
    when 'new'
      @contact = create_new
      @contact.save
      more_options_prompt
    when 'list'
      Contact.find_all.each { |contact| contact.to_s }
    when 'show'
      show_prompt
    when 'find'
      @contact = Contact.find(@parameters[0])
       more_options_prompt if @contact
    when 'help'
      help
    else
      help
    end
  end

end

Main.new