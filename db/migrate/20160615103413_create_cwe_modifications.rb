class CreateCweModifications < ActiveRecord::Migration
  def change
    create_table :cwe_modifications do |t|
      t.string :modification_source
      t.string :modifier
      t.string :modifier_org
      t.date :modification_date
      t.string :modification_comment
      t.integer :cwe_content_history_id

      t.timestamps null: false
    end
  end
end
