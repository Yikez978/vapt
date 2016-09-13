class AddSubEngagementIdToIps < ActiveRecord::Migration
  def change
  	add_column :ips, :sub_engagement_id, :integer
  end
end
