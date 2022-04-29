class CreatePayment < ActiveRecord::Migration[6.0]
  def change
    create_table :payments, id: :uuid do |t|
      t.decimal :amount
      t.integer :payment_mode
      t.text :description
      t.uuid :checkin_id
      t.uuid :booking_id
      t.date :date

      t.timestamp :deleted_at
      t.timestamps
    end
  end
end
