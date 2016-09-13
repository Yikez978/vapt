class AddIsActiveToOcbs < ActiveRecord::Migration
  def change
  	add_column :ocbs, :is_active, :boolean, default: true
  end
end
