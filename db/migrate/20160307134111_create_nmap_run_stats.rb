class CreateNmapRunStats < ActiveRecord::Migration
  def change
    create_table :nmap_run_stats do |t|
      t.integer :nmap_report_id
      t.datetime :end_time
      t.string :elapsed
      t.text :summary
      t.string :exit_status

      t.timestamps null: false
    end
  end
end
