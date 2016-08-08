class RemoveCweWeaknessIdFromCweRelationshipNotes < ActiveRecord::Migration
  def change
  	remove_column :cwe_relationship_notes, :cwe_weakness_id

  	add_column :cwe_relationship_notes, :relationship_notable_id, :integer
  	add_column :cwe_relationship_notes, :relationship_notable_type, :string
  end
end
