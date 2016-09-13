class AddMetasploitRefIdToMetasploitHostVulns < ActiveRecord::Migration
  def change
  	add_column :metasploit_host_vulns, :metasploit__ref_id, :integer
  end
end
