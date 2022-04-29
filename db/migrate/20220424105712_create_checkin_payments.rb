class CreateCheckinPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :checkin_payments do |t|
      t.uuid :checkin_id
      t.uuid :payment_id

      t.timestamp :deleted_at
      t.timestamps

      t.index [:checkin_id, :payment_id], unique: true
    end
  end
end
