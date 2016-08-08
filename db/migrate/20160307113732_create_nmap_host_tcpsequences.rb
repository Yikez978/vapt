class CreateNmapHostTcpsequences < ActiveRecord::Migration
  def change
    create_table :nmap_host_tcpsequences do |t|
      t.integer :nmap_host_id
      t.string :index
      t.text :difficulty
      t.text :values

      t.timestamps null: false
    end
  end
end
