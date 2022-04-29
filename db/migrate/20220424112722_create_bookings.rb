class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.integer :delux, default: 0
      t.integer :super_delux, default: 0
      t.boolean :basement_hall, default: false
      t.boolen :recepetion_hall, default: false
      t.text :description
      t.decimal :amount
      t.uuid :customer_id
      t.uuid :user_id
      t.datetime :checkin_time
      t.datetime :checkout_time
      t.datetime :cancelled_at

      t.timestamp :deleted_at
      t.timestamps
    end
  end
end
