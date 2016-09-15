class AddSubEngagementIdToSystemAdmins < ActiveRecord::Migration
  def change
  	add_column :system_admins, :sub_engagement_id, :integer
  end
end
