class Booking < ApplicationRecord
  acts_as_paranoid

  has_many :payments
  has_many :checkins

  belongs_to :user
  belongs_to :customer


  scope :bookings_after, -> (datetime) {
    where("checkin_time >= ?", datetime)
  }

  scope :bookings_on, -> (date) {
    where("checkin_time::date = ?", date.to_date)
  }

  scope :todays_bookings, -> {
    bookings_on(DateTime.current.to_date)
  }

end
