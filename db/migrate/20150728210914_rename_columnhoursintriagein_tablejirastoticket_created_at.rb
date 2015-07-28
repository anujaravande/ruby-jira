class RenameColumnhoursintriageinTablejirastoticketCreatedAt < ActiveRecord::Migration
  def change
  	rename_column :jiras, :hoursintriage, :ticket_created_at
  end
end
