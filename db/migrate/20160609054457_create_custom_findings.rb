class CreateCustomFindings < ActiveRecord::Migration
  def change
    create_table :custom_findings do |t|
      t.string :host
      t.string :port
      t.string :service
      t.integer :severity
      t.text :desc
      t.string :level_of_access
      t.integer :engagement_main_id

      t.timestamps null: false
    end
  end
end
