class ChangeServicesFormatInNmapReports < ActiveRecord::Migration
  def change
  	change_column :nmap_reports, :services, :text
  end
end
