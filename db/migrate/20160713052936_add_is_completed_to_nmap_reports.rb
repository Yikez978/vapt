class AddIsCompletedToNmapReports < ActiveRecord::Migration
  def change
  	add_column :nmap_reports, :is_completed, :boolean, default: false
  	add_column :metasploit_reports, :is_completed, :boolean, default: false
  end
end
