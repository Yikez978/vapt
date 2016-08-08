class CreateCweViews < ActiveRecord::Migration
  def change
    create_table :cwe_views do |t|
      t.string :name
      t.string :view_structure
      t.string :view_filter
      t.integer :cwe_weakness_catalog_id

      t.timestamps null: false
    end
  end
end
