class CheckinPayment < ApplicationRecord
  acts_as_paranoid

  belongs_to :checkin
  belongs_to :payment

end
