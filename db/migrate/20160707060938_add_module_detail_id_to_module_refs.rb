class AddModuleDetailIdToModuleRefs < ActiveRecord::Migration
  def change
  	add_column :metasploit_module_refs , :metasploit_module_detail_id, :integer
  	add_column :metasploit_module_arches , :metasploit_module_detail_id, :integer
  	add_column :metasploit_module_platforms , :metasploit_module_detail_id, :integer
  	add_column :metasploit_module_targets , :metasploit_module_detail_id, :integer
  end
end
