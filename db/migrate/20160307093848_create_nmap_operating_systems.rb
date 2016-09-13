class CreateNmapOperatingSystems < ActiveRecord::Migration
  def change
    create_table :nmap_operating_systems do |t|
      t.integer :nmap_host_id

      t.timestamps null: false
    end
  end
end
