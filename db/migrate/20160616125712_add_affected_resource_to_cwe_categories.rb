class AddAffectedResourceToCweCategories < ActiveRecord::Migration
  def change
  	add_column :cwe_categories, :affected_resource, :string
  end
end
