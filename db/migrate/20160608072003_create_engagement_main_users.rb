class CreateEngagementMainUsers < ActiveRecord::Migration
  def change
    create_table :engagement_main_users do |t|
      t.integer :user_id
      t.integer :engagement_main_id
    end
  end
end
