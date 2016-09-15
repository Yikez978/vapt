class AddEngagementIdToHosts < ActiveRecord::Migration
  def change
  	add_column :hosts, :engagement_id, :integer
  end
end
