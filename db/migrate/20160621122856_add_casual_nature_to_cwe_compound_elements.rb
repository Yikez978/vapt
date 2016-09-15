class AddCasualNatureToCweCompoundElements < ActiveRecord::Migration
  def change
  	add_column :cwe_compound_elements, :casual_nature, :string
  	add_column :cwe_compound_elements, :relevant_property, :string
  end
end
