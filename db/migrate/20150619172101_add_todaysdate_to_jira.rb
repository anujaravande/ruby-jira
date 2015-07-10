class AddTodaysdateToJira < ActiveRecord::Migration
  def change
    add_column :jiras, :todaysdate, :date
  end
end
