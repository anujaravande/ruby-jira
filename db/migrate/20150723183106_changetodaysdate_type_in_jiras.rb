class ChangetodaysdateTypeInJiras < ActiveRecord::Migration
  def change
 	change_column  :jiras, :todaysdate, :string 
	end
end


