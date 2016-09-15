class CreateNmapOsClasses < ActiveRecord::Migration
  def change
    create_table :nmap_os_classes do |t|
      t.integer :nmap_operating_system_id
      t.string :osclass_type
      t.string :vendor
      t.string :osfamily
      t.string :osgen
      t.string :accuracy

      t.timestamps null: false
    end
  end
end
