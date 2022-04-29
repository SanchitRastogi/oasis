class CreateCheckin < ActiveRecord::Migration[6.0]
  def change
    create_table :checkins do |t|
      t.datetime :checkin_time
      t.datetime :checkout_time
      t.text :destination_address
      t.text :source_address
      t.text :purpose_of_visit
      t.uuid :customer_id
      t.uuid :checkin_manager_id
      t.uuid :checkout_manager_id
      t.uuid :booking_id
      t.uuid :room_id
      t.integer :number_of_guests
      t.jsonb :guest_details
      t.decimal :tariff_amount
      t.decimal :tax_amount, default: 0
      t.decimal :fooding_amount, default: 0
      t.decimal :discount, default: 0
      t.integer :plan

      t.timestamp :deleted_at
      t.timestamps
    end
  end
end
