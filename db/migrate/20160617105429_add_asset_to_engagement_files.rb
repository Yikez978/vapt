class AddAssetToEngagementFiles < ActiveRecord::Migration
  def up
    add_attachment :engagement_files, :asset
  end

  def down
    remove_attachment :engagement_files, :asset
  end
end
