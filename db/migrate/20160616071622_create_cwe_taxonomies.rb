class CreateCweTaxonomies < ActiveRecord::Migration
  def change
    create_table :cwe_taxonomies do |t|
      t.string :mapped_taxonomy_name
      t.string :mapped_node_id
      t.string :mapped_node_name
      t.string :mapping_fit
      t.integer :taxonomy_id
      t.string :taxonomy_type

      t.timestamps null: false
    end
  end
end
