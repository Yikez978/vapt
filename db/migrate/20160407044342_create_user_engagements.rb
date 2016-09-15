class CreateUserEngagements < ActiveRecord::Migration
  def change
    create_table :user_engagements do |t|
      t.integer :user_id
      t.integer :engagement_id

      t.timestamps null: false
    end
  end
end
