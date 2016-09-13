class CreateCweCategories < ActiveRecord::Migration
  def change
    create_table :cwe_categories do |t|
      t.integer :cwe_cat_id
      t.string :name
      t.string :cat_status
      t.text :desc
      t.integer :cwe_weakness_catalog_id

      t.timestamps null: false
    end
  end
end
