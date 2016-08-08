class CreateMetasploitHosts < ActiveRecord::Migration
  def change
    create_table :metasploit_hosts do |t|
      t.string :metasploit_created_at
      t.string :address
      t.string :mac
      t.string :comm
      t.string :name
      t.string :state
      t.string :os_name
      t.string :os_flavor
      t.string :os_sp
      t.string :os_lang
      t.string :arch
      t.string :workspace_id
      t.string :updated_at
      t.string :purpose
      t.string :info
      t.string :scope
      t.string :note_count
      t.string :vuln_count
      t.string :service_count
      t.string :host_detail_count
      t.string :exploit_attempt_count
      t.string :cred_count
      t.string :history_count
      t.string :detected_arch
      t.integer :metasploit_report_id

      t.timestamps null: false
    end
  end
end
