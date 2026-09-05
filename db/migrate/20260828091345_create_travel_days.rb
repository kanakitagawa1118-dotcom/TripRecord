class CreateTravelDays < ActiveRecord::Migration[7.2]
  def change
    create_table :travel_days do |t|
      t.date :date
      t.integer :day_number
      t.string :day_title
      t.text :memo
      t.integer :tweet_id

      t.timestamps
    end
  end
end
