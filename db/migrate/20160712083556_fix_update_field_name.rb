class FixUpdateFieldName < ActiveRecord::Migration
  def change
  	rename_column :metasploit_hosts, :updated_at, :metasploit_updated_at
  	rename_column :metasploit_hosts, :scope, :metasploit_scope
  end
end
