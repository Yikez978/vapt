class AddAffectedResourceToWeaknesses < ActiveRecord::Migration
  def change
  	add_column :cwe_weaknesses, :affected_resource, :string
  end
end
