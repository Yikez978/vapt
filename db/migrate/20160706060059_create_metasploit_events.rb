class CreateMetasploitEvents < ActiveRecord::Migration
  def change
    create_table :metasploit_events do |t|
      t.integer :event_id
      t.integer :workspace_id
      t.integer :host_id
      t.datetime :metasploit_created_at
      t.string :name
      t.datetime :metasploit_updated_at
      t.string :critical
      t.string :seen
      t.string :username
      t.text :info
      t.string :module_rhost
      t.string :module_name
      t.integer :metasploit_report_id

      t.timestamps null: false
    end
  end
end
