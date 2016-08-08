class AddFullPathToEvidences < ActiveRecord::Migration
  def change
    add_column :evidences, :full_path, :string
  end
end
