class CreateNmapHostIpidsequences < ActiveRecord::Migration
  def change
    create_table :nmap_host_ipidsequences do |t|
      t.integer :nmap_host_id
      t.text :values
      t.text :description

      t.timestamps null: false
    end
  end
end
