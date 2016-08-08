class CreateCweWeaknessCatalogs < ActiveRecord::Migration
  def change
    create_table :cwe_weakness_catalogs do |t|
      t.string :catalog_name
      t.string :catalog_version
      t.date :catalog_date

      t.timestamps null: false
    end
  end
end
