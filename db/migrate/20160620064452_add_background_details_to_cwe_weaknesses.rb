class AddBackgroundDetailsToCweWeaknesses < ActiveRecord::Migration
  def change
  	add_column :cwe_weaknesses, :background_details, :text
  end
end
