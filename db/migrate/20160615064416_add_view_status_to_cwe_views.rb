class AddViewStatusToCweViews < ActiveRecord::Migration
  def change
  	add_column :cwe_views, :view_status, :string
  	add_column :cwe_views, :view_id, :integer
  	add_column :cwe_views, :view_objective, :text
  end
end
