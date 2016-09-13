class RemoveIsDeletedFromEngagements < ActiveRecord::Migration
  def change
  	remove_column :engagements, :is_deleted
  end
end
