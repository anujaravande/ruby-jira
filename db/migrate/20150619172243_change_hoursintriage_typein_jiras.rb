class ChangeHoursintriageTypeinJiras < ActiveRecord::Migration
  def self.up
  change_column :jiras, :hoursintriage, :datetime
  end
def self.down
	change_column :jiras, :hoursintriage, :date 
end

end
