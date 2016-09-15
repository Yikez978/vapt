class AddMacToEngagementMain < ActiveRecord::Migration
  def change
  	add_column :engagement_mains, :mac, :string
  end
end
