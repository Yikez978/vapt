class CreateCveDatabaseComments < ActiveRecord::Migration
  def change
    create_table :cve_database_comments do |t|
      t.integer :cve_database_id
      t.string :voter
      t.text :comment

      t.timestamps null: false
    end
  end
end
