class Addreportdetails < ActiveRecord::Migration
  def change
  add_column :reports, :issuekey, :string 
  
  add_column :reports, :current_status, :string 
  add_column :reports, :time_in_codereview, :datetime
  
  end
end
