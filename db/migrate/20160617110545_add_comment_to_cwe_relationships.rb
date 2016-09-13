class AddCommentToCweRelationships < ActiveRecord::Migration
  def change
  	add_column :cwe_relationships, :comment, :string
  end
end
