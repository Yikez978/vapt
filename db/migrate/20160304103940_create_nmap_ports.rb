class CreateNmapPorts < ActiveRecord::Migration
  def change
    create_table :nmap_ports do |t|
      t.integer :nmap_host_id
      t.string :protocol
      t.string :port
      t.string :state
      t.string :reason
      t.string :service_name
      t.string :product
      t.string :version
      t.string :extra_info
      t.string :os_type
      t.string :fingerprint_method
      t.string :fingerprint
      t.string :confidence
      t.string :device_type

      t.timestamps null: false
    end
  end
end