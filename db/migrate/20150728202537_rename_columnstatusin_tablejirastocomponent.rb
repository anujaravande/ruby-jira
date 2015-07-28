class RenameColumnstatusinTablejirastocomponent < ActiveRecord::Migration
  def change
  	rename_column :jiras, :status, :component
  end
end
