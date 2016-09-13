class AddUserIdToEngagements < ActiveRecord::Migration
  def change
    add_column :engagements, :user_id, :integer
  end
end
