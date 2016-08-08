class CreateMetasploitCredentialOrigins < ActiveRecord::Migration
  def change
    create_table :metasploit_credential_origins do |t|
      t.integer :origin_id
      t.integer :service_id
      t.string :module_full_name
      t.datetime :metasploit_created_at
      t.datetime :metasploit_updated_at
      t.integer :metasploit_report_id

      t.timestamps null: false
    end
  end
end
