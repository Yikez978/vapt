class AddEngagementIdToNmaps < ActiveRecord::Migration
  def change
    add_column :nmap_reports, :engagement_id, :integer
  end
end
