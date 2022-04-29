class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.integer :room_type
      t.text :description

      t.timestamp :deleted_at
      t.timestamps
    end
  end
end
