class CreateGrowths < ActiveRecord::Migration
  def change
    create_table :growths do |t|
      t.date :year, null: false
      t.integer :comedian_id, null: false
      t.float :rate, null: false
      t.integer :last_year_count, null: false
      t.integer :this_year_count, null: false
      t.timestamps null: false
    end
  end
end
