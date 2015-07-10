class CreateManagerdets < ActiveRecord::Migration
  def change
    create_table :managerdets do |t|
      t.string :component
      t.string :name

      t.timestamps null: false
    end
  end
end
