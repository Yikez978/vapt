class CreateMetasploitModuleTargets < ActiveRecord::Migration
  def change
    create_table :metasploit_module_targets do |t|
      t.integer :module_target_id
      t.string :name
      t.integer :metasploit_index

      t.timestamps null: false
    end
  end
end
