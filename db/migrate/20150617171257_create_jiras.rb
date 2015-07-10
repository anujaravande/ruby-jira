class CreateJiras < ActiveRecord::Migration
  def change
    create_table :jiras do |t|
      t.string :issuekey
      t.string :projectname
      t.string :status

      t.timestamps null: false
    end
  end
end
