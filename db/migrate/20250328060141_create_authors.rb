class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :description
      t.string :email

      t.timestamps
    end
    add_index :authors, :email, unique: true
  end
end
