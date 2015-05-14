require 'pry' # incase you want to use binding.pry
require 'active_record'
require_relative 'contact'
require_relative 'phone_number'

# Output messages from AR to STDOUT
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "Establishing connection to database ..."
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'unicode',
  pool: 5,
  database: 'd85rev9pvip07q',
  username: 'ifduxfxmzrcmeh',
  password: 'oXFX1ZqyMmcNR64FLLjE0AkqBI',
  host: 'ec2-107-22-187-89.compute-1.amazonaws.com',
  port: 5432,
  min_messages: 'error'
)
puts "CONNECTED"
