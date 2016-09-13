class CreateMetasploitModuleAuthors < ActiveRecord::Migration
  def change
    create_table :metasploit_module_authors do |t|
      t.integer :author_id
      t.integer :metasploit_module_detail_id
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
