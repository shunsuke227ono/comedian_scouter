class CreateComedians < ActiveRecord::Migration
  def change
    create_table :comedians do |t|
      t.string :name, null: false
      t.string :img
      t.timestamps null: false
    end
  end
end
