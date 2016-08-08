class CreateMetasploitCredentialPublics < ActiveRecord::Migration
  def change
    create_table :metasploit_credential_publics do |t|
      t.integer :public_id
      t.string :username
      t.datetime :metasploit_created_at
      t.datetime :metasploit_updated_at
      t.integer :metasploit_report_id

      t.timestamps null: false
    end
  end
end
