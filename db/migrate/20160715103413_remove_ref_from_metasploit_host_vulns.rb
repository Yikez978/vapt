class RemoveRefFromMetasploitHostVulns < ActiveRecord::Migration
  def change
  	remove_column :metasploit_host_vulns, :ref
  end
end
