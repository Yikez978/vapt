class CreateEngagements < ActiveRecord::Migration
  def change
    create_table :engagements do |t|
      t.string :engagement_name
      t.string :OCB_number

      t.timestamps null: false
    end
  end
end
