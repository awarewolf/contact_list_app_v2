require 'pry' # incase you want to use binding.pry
require 'active_record'
require_relative 'contact'
require_relative 'phone_number'
require_relative 'custom_errors'

# Output messages from AR to STDOUT
# ActiveRecord::Base.logger = Logger.new(STDOUT)

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

# ActiveRecord::Schema.define do
#   drop_table :contacts if ActiveRecord::Base.connection.table_exists?(:contacts)
#   drop_table :phone_numbers if ActiveRecord::Base.connection.table_exists?(:phone_numbers)
#   create_table :contacts do |t|
#     t.column :firstname, :string
#     t.column :lastname, :string
#     t.column :lastname, :string
#   end
#   create_table :phone_number do |table|
#     table.references :contacts
#     table.column :phone_number, :string
#     table.column :location, :string
#   end
# end