class CreateNmapReports < ActiveRecord::Migration
  def change
    create_table :nmap_reports do |t|
      t.string :path
      t.string :name
      t.string :version
      t.text :arguments
      t.string :start_time
      t.string :xmloutputversion
      t.string :scan_type
      t.string :protocol
      t.string :services
      t.boolean :debugging
      t.boolean :verbose

      t.timestamps null: false
    end
  end
end
