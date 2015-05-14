
class PhoneNumber < ActiveRecord::Base

  belongs_to :contact
  validates_associated :contact
  validates :phone_number, presence: true
  validates :phone_number, format: {with: /\d{3}-\d{3}-\d{4}/, message: "format is invalid"}

  def to_s
    "#{phone_number}: #{location}"
  end

end
