
class PhoneNumber

  attr_reader :id
  attr_accessor :contact_id, :number, :location

  def initialize (contact_id, number, location=nil, id=nil)
    @contact_id = contact_id
    @number = number
    @location = location
    @id = id
  end

  def is_new?
    @id.nil?
  end

  def valid?
    !(@number.empty? || @number.nil? || @contact_id.nil?)
  end

  def save
    raise InvalidPhoneNumberError,'ERROR: This is an invalid phone number.' unless valid?
    if is_new?
      result = Connection.db.exec_params('INSERT INTO phone_numbers (contact_id, phone_number, location) VALUES ($1, $2, $3) returning id', [@contact_id, @number, @location])
    @id = result[0]['id']
    else
      Connection.db.exec_params('UPDATE phone_numbers SET contact_id= $1, number=$2, location=$3  WHERE id = $4', [@contact_id, @number, @location, @id])
    end
  end

  def destroy
    Connection.db.exec_params('DELETE FROM phone_numbers WHERE id = $1', [@id])
  end

  def self.fill_results_from(query)
    results = []
    query.each do |row|
      results << PhoneNumber.new(
      row['contact_id'],
      row['number'],
      row['location'],
      row['id'])
    end
    results
  end

  def self.find_all_for(contact_id)
    fill_results_from Connection.db.exec_params('SELECT id, phone_number, location FROM phone_numbers WHERE contact_id = $1', [contact_id])
  end

end
