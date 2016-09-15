class CreateNmapCpes < ActiveRecord::Migration
  def change
    create_table :nmap_cpes do |t|
      t.integer :nmap_port_id
      t.string :part
      t.string :vendor
      t.string :product
      t.string :version
      t.string :cpe_update
      t.string :edition
      t.string :language

      t.timestamps null: false
    end
  end
end
