require_relative 'invalid_contact_error'
require_relative 'connection'

class Contact

  attr_reader :id
  attr_accessor :firstname, :lastname, :email

  def initialize (firstname, lastname, email, id=nil)
    # The constructor / initializer. Used to represent a contact instance in memory. Does not talk to the database.
    @firstname = firstname
    @lastname = lastname
    @email = email
    @id = id
  end

  def is_new?
    @id.nil?
  end

  def valid?
    !(@firstname.empty? || @lastname.empty? || @email.empty?)
  end

  def save
    # Either inserts or updates a row in the database, as necessary for the given instance of contact.
    # Ask yourself / discuss: When save is called, how will it know whether to run an INSERT or UPDATE SQL statement?
    raise InvalidContactError,'ERROR: This is an invalid contact.' unless valid?
    if is_new?
      result = Connection.db.exec_params('INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) returning id', [@firstname, @lastname, @email])
      @id = result[0]['id']
    else
      Connection.db.exec_params('UPDATE contacts SET firstname= $1, lastname=$2, email=$3  WHERE id = $4', [@firstname, @lastname, @email, @id])
    end
  end

  def destroy
    # Executes a DELETE SQL command against the database.
    # Ask yourself / discuss: What will it need to provide the database as part of the DELETE SQL statement?
    Connection.db.exec_params('DELETE FROM contacts WHERE id = $1', [@id])
  end

  def self.fill_results_from(query)
      results = []
      query.each do |row|
        results << Contact.new(
        row['firstname'],
        row['lastname'],
        row['email'],
        row['id'])
      end
      results
  end

  def self.find(id)
    # A class method to SELECT a contact row from the database by id and return a Contact instance that represents ("maps to") that row.
    # Ask yourself / discuss: Why is this a class method and not an instance method?
    (fill_results_from Connection.db.exec_params('SELECT id, firstname, lastname, email FROM contacts WHERE id = $1 LIMIT 1', [id])).first
  end

  def self.find_all_by_lastname(name)
    # Another class method, but this one returns an array of all contacts that have the provided last name. If none are found, an empty array should be returned.
    # It will do an exact string match.
    fill_results_from Connection.db.exec_params('SELECT id, firstname, lastname, email FROM contacts WHERE lastname = $1',[name])
  end

  def self.find_all_by_firstname(name)
    # Same as Contact.find_all_by_lastname(name) but for first name instead.
    fill_results_from Connection.db.exec_params('SELECT id, firstname, lastname, email FROM contacts WHERE firstname = $1',[name])
  end

  def self.find_by_email(email)
    # Almost identical to the other two methods above. However, since emails are assumed to be unique, we return only a single record (or nil) here. Hence why we use find_by_ instead of find_all_by for this method name.
    fill_results_from Connection.db.exec_params('SELECT id, firstname, lastname, email FROM contacts WHERE email = $1',[email])
  end

end
