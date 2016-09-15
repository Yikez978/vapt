class AddEngagementIdToIps < ActiveRecord::Migration
  def change
  	add_column :ips, :engagement_id, :integer
  end
end
