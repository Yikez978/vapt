class CreateCodeBlocks < ActiveRecord::Migration
  def change
    create_table :code_blocks do |t|
      t.text :code_block
      t.string :code_example_lang
      t.text :desc
      t.string :cwe_demonstrative_example_id

      t.timestamps null: false
    end
  end
end
