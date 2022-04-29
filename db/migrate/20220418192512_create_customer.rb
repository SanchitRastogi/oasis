class CreateCustomer < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :name
      t.string :mobile_number
      t.date :date_of_birth
      t.integer :gender
      t.string :billing_name
      t.string :gst_number
      t.string :address
      t.integer :state
      t.string :pincode

      t.timestamp :deleted_at
      t.timestamps

      t.index :mobile_number, unique: true
    end
  end
end
