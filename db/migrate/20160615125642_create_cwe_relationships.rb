class CreateCweRelationships < ActiveRecord::Migration
  def change
    create_table :cwe_relationships do |t|
      t.integer :relationship_view_id
      t.string :ordinal
      t.string :target_form
      t.string :nature
      t.integer :target_id
      t.integer :relation_id
      t.string :relation_type

      t.timestamps null: false
    end
  end
end
