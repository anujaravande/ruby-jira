class AddJirastatusToDayDatum < ActiveRecord::Migration
  def change
    add_column :day_data, :jirastatus, :string
  end
end
