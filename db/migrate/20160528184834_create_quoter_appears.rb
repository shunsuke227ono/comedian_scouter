class CreateQuoterAppears < ActiveRecord::Migration
  def change
    create_table :quoter_appears do |t|

      t.timestamps null: false
    end
  end
end
