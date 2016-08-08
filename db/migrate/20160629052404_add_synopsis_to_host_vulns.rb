class AddSynopsisToHostVulns < ActiveRecord::Migration
  def change
  	add_column :host_vulns, :synopsis, :text
  end
end
