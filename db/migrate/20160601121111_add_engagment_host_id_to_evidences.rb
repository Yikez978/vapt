class AddEngagmentHostIdToEvidences < ActiveRecord::Migration
  def change
    add_column :evidences, :engagement_id, :integer
    add_column :evidences, :engagement_main_id, :integer
  end
end
