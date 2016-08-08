class CreateMetasploitModulePlatforms < ActiveRecord::Migration
  def change
    create_table :metasploit_module_platforms do |t|
      t.integer :module_platform_id
      t.string :name

      t.timestamps null: false
    end
  end
end
