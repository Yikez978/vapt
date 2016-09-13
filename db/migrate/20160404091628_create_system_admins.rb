class CreateSystemAdmins < ActiveRecord::Migration
  def change
    create_table :system_admins do |t|
      t.string :name
      t.integer :engagement_id

      t.timestamps null: false
    end
  end
end
