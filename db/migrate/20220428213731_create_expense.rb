class CreateExpense < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses, id: :uuid do |t|
      t.decimal :amount
      t.string :name
      t.text :description
      t.integer :type
      t.date :date

      t.timestamp :deleted_at
      t.timestamps
    end
  end
end
