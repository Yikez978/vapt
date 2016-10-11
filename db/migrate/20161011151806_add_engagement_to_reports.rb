class AddEngagementToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :engagement, index: true, foreign_key: true
  end
end
