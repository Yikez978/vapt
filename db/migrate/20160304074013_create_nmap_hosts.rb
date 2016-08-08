class CreateNmapHosts < ActiveRecord::Migration
  def change
    create_table :nmap_hosts do |t|
      t.integer :nmap_report_id
      t.string :ip
      t.string :ipv4
      t.string :ipv6
      t.string :address
      t.string :mac
      t.string :vendor

      t.timestamps null: false
    end
  end
end
