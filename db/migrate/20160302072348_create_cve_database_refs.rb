class CreateCveDatabaseRefs < ActiveRecord::Migration
  def change
    create_table :cve_database_refs do |t|
      t.integer :cve_database_id
      t.text :ref
      t.string :source
      t.text :url

      t.timestamps null: false
    end
  end
end
