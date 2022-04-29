class Payment < ActiveRecord
  acts_as_paranoid

  has_many :checkins
  belongs_to :booking

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  enum :payment_mode, { cash: 0, bank_account: 1 }
end
