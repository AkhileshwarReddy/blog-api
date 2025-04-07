class AddMaxReadDaysToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :max_read_days, :integer
  end
end
