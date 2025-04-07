class CreateBorrows < ActiveRecord::Migration[7.1]
  def change
    create_table :borrows do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :borrowed_date
      t.datetime :estimated_return_date
      t.datetime :actual_return_date

      t.timestamps
    end
  end
end
