class CreateDailySprints < ActiveRecord::Migration
  def change
    create_table :daily_sprints do |t|
      t.datetime :day
      t.text :componenthash
      t.string :status

      t.timestamps null: false
    end
  end
end
