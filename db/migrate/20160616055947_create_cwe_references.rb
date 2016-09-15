class CreateCweReferences < ActiveRecord::Migration
  def change
    create_table :cwe_references do |t|
      t.string :ref_id
      t.text :ref_author
      t.string :ref_title
      t.string :ref_section
      t.string :ref_edition
      t.string :ref_publisher
      t.date :ref_pubdate
      t.date :ref_date
      t.string :ref_link
      t.integer :referable_id
      t.string :referable_type

      t.timestamps null: false
    end
  end
end
