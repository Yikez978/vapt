class AddLineToNmapOsMatches < ActiveRecord::Migration
  def change
  	add_column :nmap_os_matches, :line, :string
  end
end
