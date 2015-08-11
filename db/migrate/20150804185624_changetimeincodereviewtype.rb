class Changetimeincodereviewtype < ActiveRecord::Migration
  def change
  
 	change_column  :reports, :time_in_codereview, :integer
	
  end
end
