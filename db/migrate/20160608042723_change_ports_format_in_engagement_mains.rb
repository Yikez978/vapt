class ChangePortsFormatInEngagementMains < ActiveRecord::Migration
  def change
  	change_column :engagement_mains, :ports, :text
  end
end
