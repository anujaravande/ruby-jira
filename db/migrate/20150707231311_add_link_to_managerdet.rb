class AddLinkToManagerdet < ActiveRecord::Migration
  def change
    add_column :managerdets, :link, :string
  end
end
