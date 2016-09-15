class AddUserIdToPocs < ActiveRecord::Migration
  def change
  	add_column :pocs, :user_id, :integer
  	remove_column :pocs, :name
  end
end
