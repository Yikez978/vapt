class RemoveNameFromOcbs < ActiveRecord::Migration
  def change
    remove_column :ocbs, :name
  end
end