class AddColumnstoTests < ActiveRecord::Migration
  def change
  add_column :tests, :issuekey, :string 
  add_column :tests, :projectname, :string 
  add_column :tests, :ticket_created_at, :string 
  add_column :tests, :status, :string
  end
end
