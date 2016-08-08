class CreateCweMaintenanceNotes < ActiveRecord::Migration
  def change
    create_table :cwe_maintenance_notes do |t|
      t.text :note
      t.integer :maintenable_id
      t.string :maintenable_type

      t.timestamps null: false
    end
  end
end
