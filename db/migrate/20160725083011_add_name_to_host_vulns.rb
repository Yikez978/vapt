class AddNameToHostVulns < ActiveRecord::Migration
  def change
  	add_column :host_vulns, :vuln_name, :string
  end
end
