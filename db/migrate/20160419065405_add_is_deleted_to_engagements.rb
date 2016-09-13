class AddIsDeletedToEngagements < ActiveRecord::Migration
  def change
  	add_column :engagements, :is_deleted, :boolean, default: false
  end
end
