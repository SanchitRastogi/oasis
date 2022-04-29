class Expense < ActiveRecord
  acts_as_paranoid

  validates :name, presence: true, length: { minimum: 2, maximum: 40 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  enum :type, { others: 0, salary: 1, grocery: 2, maintenance: 3, bills: 4, guest_related: 5, transport: 6 }
end
