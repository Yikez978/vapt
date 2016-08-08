class CreateCweRelationshipNotes < ActiveRecord::Migration
  def change
    create_table :cwe_relationship_notes do |t|
      t.text :note
      t.integer :cwe_weakness_id

      t.timestamps null: false
    end
  end
end
