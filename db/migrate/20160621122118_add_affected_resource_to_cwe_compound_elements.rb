class AddAffectedResourceToCweCompoundElements < ActiveRecord::Migration
  def change
  	add_column :cwe_compound_elements, :affected_resource, :string
  end
end
