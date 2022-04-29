class Checkin < ActiveRecord
  acts_as_paranoid

  has_one :booking

  # has_many :checkin_rooms
  # has_many :rooms, through: :checkin_rooms
  has_many :identification_docs
  has_many :payments

  belongs_to :customer
  belongs_to :checkin_manager, class_name: 'User'
  belongs_to :checkout_manager, class_name: 'User'
  belongs_to :user
  belongs_to :booking
  belongs_to :room

  validates :number_of_guests, presence: true, numericality: { only_integer: true,  greater_than: 0 }
  validates :tariff_amount, presence: true, numericality: { greater_than: 0 }
  validates :checkin_time, presence: true
  validates :room_id, presence: true

  enum :plan, { map: 0, cp: 1 }

  scope :todays_checkin, -> {
    where("checkin_time::date = ?", DateTime.current.to_date)
  }

  scope :occupied_rooms, -> {
    where("checkin_time <= ?", Datetime.current).where("checkout_time is null OR checkout_time > ?", DateTime.current)
  }

end
