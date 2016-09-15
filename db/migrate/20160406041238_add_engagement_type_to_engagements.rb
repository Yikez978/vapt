class AddEngagementTypeToEngagements < ActiveRecord::Migration
  def change
  	add_column :engagements, :engagement_type_id, :integer
  end
end
