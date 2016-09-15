class AddCasualNatureToCweWeaknesses < ActiveRecord::Migration
  def change
  	add_column :cwe_weaknesses, :casual_nature, :string
  end
end
