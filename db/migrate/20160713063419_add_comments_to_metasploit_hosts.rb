class AddCommentsToMetasploitHosts < ActiveRecord::Migration
  def change
  	add_column :metasploit_hosts, :comments, :text
  	add_column :metasploit_hosts, :virtual_host, :string
  end
end
