
class PhoneNumber < ActiveRecord::Base

  belongs_to :contact
  validates_associated :contact
  validates :phone_number, presence: true
  # validates :phone_number, format: {with: /^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$/, message: "Please enter a valid phone number format"}

end
