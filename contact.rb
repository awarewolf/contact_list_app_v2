
class Contact < ActiveRecord::Base

  has_many :phone_numbers
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  # validates :email, format: {with: /[\w]+@[\w]+\.[\w]+/, message: "Please enter a valid email"}

  def to_s
    "#{id}: #{firstname} #{lastname} (#{email})"
  end

end
