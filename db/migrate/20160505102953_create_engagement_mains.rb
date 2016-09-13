class CreateEngagementMains < ActiveRecord::Migration
  def change
    create_table :engagement_mains do |t|
      t.string :host
      t.string :ports
      t.string :services
      t.string :vulns
      t.string :exploits
      t.string :host_name
      t.string :purpose
      t.string :os
      t.integer :user_id
      t.integer :engagement_id
      
      t.timestamps null: false
    end
  end
end
