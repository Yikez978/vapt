class CreateMetasploitCredentialCores < ActiveRecord::Migration
  def change
    create_table :metasploit_credential_cores do |t|
      t.integer :core_id
      t.integer :origin_id
      t.string :origin_type
      t.integer :private_id
      t.integer :public_id
      t.string :realm_id
      t.integer :workspace_id
      t.datetime :metasploit_created_at
      t.datetime :metasploit_updated_at
      t.integer :logins_count
      t.integer :metasploit_report_id

      t.timestamps null: false
    end
  end
end
