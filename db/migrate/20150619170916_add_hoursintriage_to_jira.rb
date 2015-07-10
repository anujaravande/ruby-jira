class AddHoursintriageToJira < ActiveRecord::Migration
  def change
    add_column :jiras, :hoursintriage, :time
  end
end
