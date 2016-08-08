class CreateSubEngagements < ActiveRecord::Migration
  def change
    create_table :sub_engagements do |t|
      t.string :sub_engagement_name
      t.integer :engagement_id

      t.timestamps null: false
    end
  end
end
