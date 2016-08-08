class CreateCveDatabases < ActiveRecord::Migration
  def change
    create_table :cve_databases do |t|
      t.string :cve_database_id
      t.string :status
      t.string :phase
      t.string :phase_date
      t.text :desc

      t.timestamps null: false
    end
  end
end
