class AddEngagementIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :engagement_id, :integer
  end
end
