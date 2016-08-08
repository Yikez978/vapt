class CreateNmapScripts < ActiveRecord::Migration
  def change
    create_table :nmap_scripts do |t|
      t.integer :nmap_port_id
      t.string :key
      t.text :value

      t.timestamps null: false
    end
  end
end
