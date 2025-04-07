class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :isbn
      t.integer :copies
      t.string :name
      t.integer :late_return_penalty
      t.references :publisher_author, null: false, foreign_key: true

      t.timestamps
    end
    add_index :books, :isbn, unique: true
  end
end
