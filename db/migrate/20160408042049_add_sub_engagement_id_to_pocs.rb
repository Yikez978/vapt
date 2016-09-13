class AddSubEngagementIdToPocs < ActiveRecord::Migration
  def change
  	add_column :pocs, :sub_engagement_id, :integer
  end
end
