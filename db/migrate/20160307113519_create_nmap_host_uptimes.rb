class CreateNmapHostUptimes < ActiveRecord::Migration
  def change
    create_table :nmap_host_uptimes do |t|
      t.integer :nmap_host_id
      t.string :seconds
      t.string :last_boot

      t.timestamps null: false
    end
  end
end
