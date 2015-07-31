class AddInSprinttoJiras < ActiveRecord::Migration
  def change
  add_column :jiras, :InSprint, :string

  end
end
