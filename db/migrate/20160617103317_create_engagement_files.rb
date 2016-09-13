class CreateEngagementFiles < ActiveRecord::Migration
  def change
    create_table :engagement_files do |t|
      t.integer :user_id
      t.integer :engagement_id

      t.timestamps null: false
    end
  end
end
