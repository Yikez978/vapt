class AddEngagementIdToPocs < ActiveRecord::Migration
  def change
  	add_column :pocs, :engagement_id, :integer
  end
end
