class Room < ApplicationRecord
  acts_as_paranoid

  # has_many :checkin_rooms, foreign_key: 'room_name', primary_key: 'room_name'
  # has_many :checkins, through: :checkin_rooms
  has_many :checkins
  has_many :bookings

  enum :room_type, { delux: 0, super_delux: 1, hall: 2 }
end

