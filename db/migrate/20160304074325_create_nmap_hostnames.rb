class CreateNmapHostnames < ActiveRecord::Migration
  def change
    create_table :nmap_hostnames do |t|
      t.integer :nmap_host_id
      t.string :host_type
      t.string :name

      t.timestamps null: false
    end
  end
end
