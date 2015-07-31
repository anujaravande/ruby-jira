class AddInSprinttoDayDatum < ActiveRecord::Migration
  def change
  add_column :day_data, :InSprint, :string

  end
end
