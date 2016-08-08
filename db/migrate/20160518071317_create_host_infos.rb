class CreateHostInfos < ActiveRecord::Migration
  def change
    create_table :host_infos do |t|
      t.string :ip
      t.string :mac
      t.string :host_name
      t.string :os
      t.string :service_port
      t.string :service_protocol
      t.string :service_name
      t.string :service_banner

      t.timestamps null: false
    end
  end
end
