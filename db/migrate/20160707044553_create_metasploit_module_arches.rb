class CreateMetasploitModuleArches < ActiveRecord::Migration
  def change
    create_table :metasploit_module_arches do |t|
      t.integer :module_archs_id
      t.string :name

      t.timestamps null: false
    end
  end
end
