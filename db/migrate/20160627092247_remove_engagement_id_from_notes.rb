class RemoveEngagementIdFromNotes < ActiveRecord::Migration
  def change
  	remove_column :notes, :engagement_id
  end
end
