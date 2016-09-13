class CreateMetasploitHostNotes < ActiveRecord::Migration
  def change
    create_table :metasploit_host_notes do |t|
      t.integer :note_id
      t.datetime :metasploit_created_at
      t.datetime :metasploit_updated_at
      t.string :ntype
      t.integer :workspace_id
      t.integer :service_id
      t.string :critical
      t.string :seen
      t.string :vuln_id
      t.text :data
      t.integer :metasploit_host_id

      t.timestamps null: false
    end
  end
end
