class CreatePublisherAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :publisher_authors do |t|
      t.references :author, null: false, foreign_key: true
      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
