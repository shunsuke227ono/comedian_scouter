class CreateCoAppears < ActiveRecord::Migration
  def change
    create_table :co_appears do |t|
      t.integer :count, default: 0
      t.integer :comedian_id_1, null: false
      t.integer :comedian_id_2, null: false

      t.timestamps null: false
    end
  end
end
