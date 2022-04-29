class User < ApplicationRecord
  acts_as_paranoid

  has_many :checkins, foreign_key: 'checkin_manager_id'
  has_many :checkouts, class_name: 'Checkin', foreign_key: 'checkout_manager_id'
  has_many :bookings
end

