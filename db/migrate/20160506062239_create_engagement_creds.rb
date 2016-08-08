class CreateEngagementCreds < ActiveRecord::Migration
  def change
    create_table :engagement_creds do |t|
      t.string :ip
      t.text :pwdump
      t.string :password
      t.text :description
      t.integer :user_id
      t.integer :engagement_id

      t.timestamps null: false
    end
  end
end
