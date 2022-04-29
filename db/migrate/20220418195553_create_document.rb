class CreateDocument < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.references :documentable, polymorphic: true, index: true
      t.string :document
      t.integer :doc_type
      t.timestamp :deleted_at
      t.text :notes

      t.timestamp :deleted_at
      t.timestamps
    end
  end
end
