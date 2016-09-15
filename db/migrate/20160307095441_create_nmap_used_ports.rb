class CreateNmapUsedPorts < ActiveRecord::Migration
  def change
    create_table :nmap_used_ports do |t|
      t.integer :nmap_operating_system_id
      t.string :state
      t.string :proto
      t.string :portid

      t.timestamps null: false
    end
  end
end
