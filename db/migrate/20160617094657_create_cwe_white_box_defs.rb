class CreateCweWhiteBoxDefs < ActiveRecord::Migration
  def change
    create_table :cwe_white_box_defs do |t|
      t.text :definition_block
      t.integer :box_defiable_id
      t.string :box_defiable_type

      t.timestamps null: false
    end
  end
end
