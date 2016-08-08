class FixUserName < ActiveRecord::Migration
  def change
  	rename_column :metasploit_reports, :user, :metasploit_user
  end
end
