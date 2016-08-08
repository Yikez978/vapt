class CreateMetasploitModuleRefs < ActiveRecord::Migration
  def change
    create_table :metasploit_module_refs do |t|
      t.integer :module_ref_id
      t.string :name

      t.timestamps null: false
    end
  end
end
