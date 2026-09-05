class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.string :companion
      t.text :memo
      t.integer :user_id

      t.timestamps
    end
  end
end
