class CreateCveDatabaseVotes < ActiveRecord::Migration
  def change
    create_table :cve_database_votes do |t|
      t.integer :cve_database_id
      t.string :count
      t.text :vote
      t.string :vote_type

      t.timestamps null: false
    end
  end
end
