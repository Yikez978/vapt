class AddMetasploitIdToMetasploitHosts < ActiveRecord::Migration
  def change
  	add_column :metasploit_hosts, :metasploit_id, :integer
  end
end
