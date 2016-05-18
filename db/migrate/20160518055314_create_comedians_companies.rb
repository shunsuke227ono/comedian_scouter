class CreateComediansCompanies < ActiveRecord::Migration
  def change
    create_table :comedians_companies do |t|
      t.integer :comedian_id, null: false
      t.integer :company_id, null: false
      t.timestamps null: false
    end
  end
end
