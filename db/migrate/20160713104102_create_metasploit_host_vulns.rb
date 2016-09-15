class CreateMetasploitHostVulns < ActiveRecord::Migration
  def change
    create_table :metasploit_host_vulns do |t|
      t.integer :vuln_id
      t.integer :service_id
      t.datetime :metasploit_created_at
      t.datetime :metasploit_updated_at
      t.string :name
      t.text :info
      t.string :exploited_at
      t.integer :vuln_detail_count
      t.integer :vuln_attempt_count
      t.string :nexpose_data_vuln_def_id
      t.string :origin_id
      t.string :origin_type
      t.text :notes
      t.string :ref
      t.text :vuln_details
      t.string :vuln_attempts
      t.integer :metasploit_host_id

      t.timestamps null: false
    end
  end
end
