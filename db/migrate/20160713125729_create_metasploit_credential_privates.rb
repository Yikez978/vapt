class CreateMetasploitCredentialPrivates < ActiveRecord::Migration
  def change
    create_table :metasploit_credential_privates do |t|
      t.integer :private_id
      t.string :private_type
      t.text :data
      t.datetime :metasploit_created_at
      t.datetime :metasploit_updated_at
      t.integer :metasploit_report_id
      t.string :jtr_format

      t.timestamps null: false
    end
  end
end
