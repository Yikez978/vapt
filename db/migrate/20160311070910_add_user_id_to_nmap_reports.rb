class AddUserIdToNmapReports < ActiveRecord::Migration
  def change
  	add_column :nmap_reports, :user_id, :integer
  end
end
