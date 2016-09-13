class AddIsCreatorToUserEngagements < ActiveRecord::Migration
  def change
  	add_column :user_engagements, :is_creator, :boolean, default: false
  end
end
