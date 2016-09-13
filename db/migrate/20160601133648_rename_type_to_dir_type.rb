class RenameTypeToDirType < ActiveRecord::Migration
  def change
    rename_column :evidences, :type, :dir_type
  end
end