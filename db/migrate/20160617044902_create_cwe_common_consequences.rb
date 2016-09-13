class CreateCweCommonConsequences < ActiveRecord::Migration
  def change
    create_table :cwe_common_consequences do |t|
      t.string :consequence_scope
      t.string :technical_impact
      t.text :note
      t.integer :consequencable_id
      t.string :consequencable_type

      t.timestamps null: false
    end
  end
end
