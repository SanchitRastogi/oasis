class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.text :password
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :mobile_number
      t.string :fcm_token
      t.boolean :is_freezed
      t.text :auth_token
      t.jsonb :address
      t.string :otp_secret_key

      t.timestamp :deleted_at
      t.timestamps

      t.index :mobile_number
    end
  end
end
