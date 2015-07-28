class ChangehoursintriageTypetoJiras < ActiveRecord::Migration
  def self.up
  change_column :jiras, :hoursintriage, :string
  end
def self.down
	change_column :jiras, :hoursintriage, :datetime 
end
end
