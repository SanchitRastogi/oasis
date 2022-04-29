class Customer < ActiveRecord
  acts_as_paranoid

  has_one :identification_doc

  has_many :checkins
  has_many :bookings

  validates :mobile_number, presence: true, format: {with: /[0-9]{10}/}, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true
  validates :gst_number, format: { with: /[0-9]{2}[a-zA-Z]{4}[0-9a-zA-Z]{1}[0-9]{4}[a-zA-Z]{1}[1-9A-Za-z]{2}[0-9a-zA-Z]{1}/}
  validates :pincode, presence: true, numericality: true, length: { is: 6 }

  enum :state, STATES
  enum :gender, { male: 0, female: 1, others: 2}
end
