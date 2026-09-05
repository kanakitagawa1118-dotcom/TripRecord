class CreateSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :schedules do |t|
      t.time :start_time
      t.time :end_time
      t.string :place
      t.string :activity
      t.text :memo
      t.integer :travel_day_id

      t.timestamps
    end
  end
end
