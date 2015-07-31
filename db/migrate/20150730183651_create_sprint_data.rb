class CreateSprintData < ActiveRecord::Migration
  def change
    create_table :sprint_data do |t|
      t.datetime :day
      t.text :componenthash
      t.string :jirastatus

      t.timestamps null: false
    end
  end
end
