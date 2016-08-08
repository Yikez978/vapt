class CreateMetasploitRefs < ActiveRecord::Migration
  def change
    create_table :metasploit_refs do |t|
      t.string :ref
      t.integer :metasploit_host_vuln_id

      t.timestamps null: false
    end
  end
end
