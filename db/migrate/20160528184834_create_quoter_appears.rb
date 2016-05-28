class CreateQuoterAppears < ActiveRecord::Migration
  def change
    create_table :quoter_appears do |t|
      t.integer :count, default: 0
      t.integer :comedian_id, null: false
      t.date :start_date, null: false
      t.timestamps null: false
    end
  end
end
