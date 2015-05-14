
class Contact < ActiveRecord::Base

  has_many :phone_numbers
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: "format is not valid"}

  def to_s
    "#{id}: #{firstname} #{lastname} (#{email})\n\t#{phone_numbers.map(&:to_s).join("\n\t")}"
  end

end
