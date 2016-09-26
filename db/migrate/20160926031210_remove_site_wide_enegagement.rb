class RemoveSiteWideEnegagement < ActiveRecord::Migration
  def change
    remove_column :engagements, :is_site_wide_engagement
  end
end
