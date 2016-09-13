class AddAncestryToEngagements < ActiveRecord::Migration
  def change
    add_column :engagements, :ancestry, :string
    add_index :engagements, :ancestry
  end
end
