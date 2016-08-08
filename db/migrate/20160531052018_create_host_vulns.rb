class CreateHostVulns < ActiveRecord::Migration
  def change
    create_table :host_vulns do |t|
      t.integer :port
      t.integer :vuln_id
      t.integer :severity
      t.string :aasm_state
      t.string :exploits
      t.string :cve
      t.string :cwe
      t.string :level_of_access
      t.integer :engagement_main_id

      t.timestamps null: false
    end
  end
end
