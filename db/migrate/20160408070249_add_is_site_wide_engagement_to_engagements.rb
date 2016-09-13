class AddIsSiteWideEngagementToEngagements < ActiveRecord::Migration
  def change
  	add_column :engagements, :is_site_wide_engagement, :boolean , default: false
  end
end
