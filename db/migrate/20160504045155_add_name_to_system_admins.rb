class AddNameToSystemAdmins < ActiveRecord::Migration
  def change
  	add_column :system_admins, :name, :string
  	remove_column :system_admins, :user_id
  end
end
