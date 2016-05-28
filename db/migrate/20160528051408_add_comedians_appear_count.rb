class AddComediansAppearCount < ActiveRecord::Migration
  def change
    add_column :comedians, :appear_count, :integer, default: 0
  end
end
