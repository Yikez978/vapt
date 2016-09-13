class CreateCweCompoundElements < ActiveRecord::Migration
  def change
    create_table :cwe_compound_elements do |t|
      t.integer :element_id
      t.string :name
      t.string :compound_element_abstraction
      t.string :compound_element_structure
      t.string :element_status
      t.text :desc_summary
      t.text :ext_desc
      t.integer :cwe_weakness_catalog_id

      t.timestamps null: false
    end
  end
end
