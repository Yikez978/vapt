class AddNameToPocs < ActiveRecord::Migration
  def change
  	add_column :pocs, :name, :string
  	remove_column :pocs, :user_id
  end
end
