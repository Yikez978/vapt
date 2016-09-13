class AddStatusToEngagementMains < ActiveRecord::Migration
  def change
  	add_column :engagement_mains, :exploit_status, :string
  end
end
