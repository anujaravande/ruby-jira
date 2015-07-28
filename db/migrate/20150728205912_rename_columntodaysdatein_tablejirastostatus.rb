class RenameColumntodaysdateinTablejirastostatus < ActiveRecord::Migration
  def change
  	rename_column :jiras, :todaysdate, :status
  end
end
