class CreateCweWeaknesses < ActiveRecord::Migration
  def change
    create_table :cwe_weaknesses do |t|
      t.string :weakness_id
      t.string :name
      t.string :weakness_abstruction
      t.string :weakness_status
      t.text :desc_summary
      t.text :ext_desc
      t.integer :cwe_weakness_catalog_id

      t.timestamps null: false
    end
  end
end
