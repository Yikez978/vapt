class ChangeVulnAttemptsType < ActiveRecord::Migration
  def change
  	change_column :metasploit_host_vulns, :vuln_attempts, :text
  end
end
