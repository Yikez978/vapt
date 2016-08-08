class AddUserIdToSystemAdmins < ActiveRecord::Migration
  def change
  	add_column :system_admins, :user_id, :integer
  	remove_column :system_admins, :name
  end
end
