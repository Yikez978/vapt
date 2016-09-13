class CreateCweAudiences < ActiveRecord::Migration
  def change
    create_table :cwe_audiences do |t|
      t.string :stakeholder
      t.text :stakeholder_desc
      t.integer :cwe_view_id

      t.timestamps null: false
    end
  end
end
