class AddColumnComedianHasMonthlyAppears < ActiveRecord::Migration
  def change
    add_column :comedians, :has_monthly_appears, :integer
  end
end
