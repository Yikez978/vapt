class AddImageLocationToCweMaintenanceNotes < ActiveRecord::Migration
  def change
  	add_column :cwe_maintenance_notes, :image_location, :string
  	add_column :cwe_maintenance_notes, :image_title, :string
  end
end
