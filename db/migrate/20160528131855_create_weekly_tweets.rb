class CreateWeeklyTweets < ActiveRecord::Migration
  def change
    create_table :weekly_tweets do |t|
      t.integer :comedian_id, null: false
      t.integer :count, default: 0
      t.date :start_date, null: false 
      t.timestamps null: false
    end
  end
end
