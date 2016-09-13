class CreateMetasploitServices < ActiveRecord::Migration
  def change
    create_table :metasploit_services do |t|
      t.integer :service_id
      t.integer :host_id
      t.datetime :metasploit_created_at
      t.datetime :metasploit_updated_at
      t.integer :port
      t.string :proto
      t.string :state
      t.string :name
      t.text :info
      t.integer :metasploit_report_id

      t.timestamps null: false
    end
  end
end
