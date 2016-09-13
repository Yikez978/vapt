class CreateMetasploitModuleDetails < ActiveRecord::Migration
  def change
    create_table :metasploit_module_details do |t|
      t.integer :module_id
      t.datetime :mtime
      t.string :file
      t.string :mtype
      t.string :refname
      t.string :fullname
      t.string :name
      t.integer :rank
      t.text :description
      t.string :license
      t.string :privileged
      t.datetime :disclosure_date
      t.string :default_target
      t.string :default_action
      t.string :stance
      t.string :ready
      t.integer :metasploit_report_id

      t.timestamps null: false
    end
  end
end
