class CreateNmapHostTraceroutes < ActiveRecord::Migration
  def change
    create_table :nmap_host_traceroutes do |t|
      t.integer :nmap_host_id
      t.string :port
      t.string :protocol
      t.string :ttl
      t.string :ipaddr
      t.string :rtt
      t.text :host

      t.timestamps null: false
    end
  end
end
