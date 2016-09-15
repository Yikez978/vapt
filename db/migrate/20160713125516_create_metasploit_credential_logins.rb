class CreateMetasploitCredentialLogins < ActiveRecord::Migration
  def change
    create_table :metasploit_credential_logins do |t|
      t.integer :login_id
      t.integer :core_id
      t.integer :service_id
      t.string :access_level
      t.string :status
      t.datetime :last_attempted_at
      t.datetime :metasploit_created_at
      t.datetime :metasploit_updated_at
      t.integer :metasploit_report_id

      t.timestamps null: false
    end
  end
end
