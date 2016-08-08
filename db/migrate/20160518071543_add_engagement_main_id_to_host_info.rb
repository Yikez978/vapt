class AddEngagementMainIdToHostInfo < ActiveRecord::Migration
  def change
  	add_column :host_infos, :engagement_main_id, :integer
  end
end
