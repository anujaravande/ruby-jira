class AddtimeInReadytomergetodailysprint < ActiveRecord::Migration
  def change
  add_column :reports, :time_in_readytomerge, :integer
  end
end
