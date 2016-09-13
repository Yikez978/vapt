class ChangeModificationCommentType < ActiveRecord::Migration
  def change
  	change_column :cwe_modifications, :modification_comment, :text
  end
end
