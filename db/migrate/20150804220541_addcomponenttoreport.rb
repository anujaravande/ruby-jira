class Addcomponenttoreport < ActiveRecord::Migration
  def change
  add_column :reports, :component, :string 
  end
end
