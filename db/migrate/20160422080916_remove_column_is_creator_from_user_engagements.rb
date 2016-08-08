class RemoveColumnIsCreatorFromUserEngagements < ActiveRecord::Migration
  def change
    remove_column :user_engagements, :is_creator
  end
end