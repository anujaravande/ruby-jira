class AddComponenttoTests < ActiveRecord::Migration
  def change
  add_column  :tests, :component, :string 
  end
end
