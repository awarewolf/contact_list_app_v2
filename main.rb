require_relative 'setup'

class Main

  def initialize
    ARGV << 'help' if ARGV.empty?
    @command = ARGV.shift.downcase
    @parameters = ARGV
    parse_arguments
  end

  def help
    puts "Here is a list of available commands:"
    puts "  new  - Create a new contact"
    puts "  list - List all contacts"
    puts "  show - Show a contact"
    puts "  find - Find a contact"
  end

  def get_phone_number_info
    phone_number = prompt_for( 'phone number' )
    location = prompt_for( 'location ([return] for none)' )
    location = nil if location.empty?
    { phone_number: phone_number, location: location }
  end

  def add_phone_number
    info = get_phone_number_info
    # PhoneNumber.new( info[:contact_id], info[:phone_number], info[:location] ) V2
    @contact.phone_numbers.create(info)
  end

  def delete_prompt
    puts "Are you sure you want to delete this contact? (y/n)"
    case prompt_for.downcase
    when 'y'
      @contact.destroy
    when 'n'
    else
      invalid_option
      delete_prompt
    end
  end

   def more_options_prompt
    puts @contact.to_s
    puts "Contact options:"
    puts "(a)dd a phone number / (d)elete the contact / [return] to exit"
    case prompt_for.downcase
    when 'a'
      add_phone_number
    when 'd'
      delete_prompt
    when ''
    else
      invalid_option
      more_options_prompt
    end
  end

  def get_contact_info
    puts "Enter new contact info:"
    firstname = prompt_for( 'first name' )
    lastname = prompt_for( 'last name' )
    email = prompt_for( 'email' )
    { firstname: firstname, lastname: lastname, email: email }
  end

  def create_new_contact
    info = get_contact_info
    # Contact.new( info[:firstname], info[:lastname], info[:email] ) V2
    contact = Contact.create(info)
    raise InvalidContactError, contact.errors.full_messages.join(', ') unless contact.errors.empty?
    contact
  end

  def show_prompt
    puts "Show contacts by:"
    puts "(f)irst name, (l)astname, (e)mail"
    case prompt_for.downcase
    when 'f'
      # Contact.find_all_by_lastname( prompt_for( 'first name' ) ).inspect V2
      Contact.find( firstname: prompt_for( 'first name' ) )
    when 'l'
      # Contact.find_all_by_lastname( prompt_for( 'last name' ) ).inspect V2
      Contact.find( lastname: prompt_for( 'last name' ) )
    when 'e'
      # Contact.find_all_by_email( prompt_for( 'email' ) ).inspect V2
      Contact.find( email: prompt_for( 'email' ) )
    else
      invalid_option
      show_prompt
    end
  end

  def prompt_for( input='' )
    print "#{input} >"
    STDIN.gets.chomp
  end

  def invalid_option
    puts 'Invalid option'
  end

  def parse_arguments
    case @command
    when 'new'
      @contact = create_new_contact
      more_options_prompt
    when 'list'
      # Contact.find_all.each { |contact| contact.to_s } V2
      Contact.all.each { |contact| puts contact.to_s }
    when 'show'
      show_prompt
    when 'find'
      @contact = Contact.find(@parameters[0].to_i)
      more_options_prompt if @contact
    when 'help'
      help
    else
      help
    end
  rescue InvalidContactError => e
    puts e.message
    retry
  end

end

Main.new