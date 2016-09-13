class RemoveHostNameFromEngagements < ActiveRecord::Migration
  def change
  	remove_column :engagements, :host_name
  	remove_column :engagements, :sys_admin_id
  	remove_column :engagements, :poc_id
  	remove_column :engagements, :ocb_id
  end
end
