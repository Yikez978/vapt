class CreateMetasploitReports < ActiveRecord::Migration
  def change
    create_table :metasploit_reports do |t|
      t.string :path
      t.string :time
      t.string :user
      t.string :project
      t.string :product
      t.integer :user_id
      t.integer :engagement_id

      t.timestamps null: false
    end
  end
end
