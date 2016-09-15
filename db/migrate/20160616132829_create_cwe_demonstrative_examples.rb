class CreateCweDemonstrativeExamples < ActiveRecord::Migration
  def change
    create_table :cwe_demonstrative_examples do |t|
      t.string :dx_id
      t.text :intro_text
      t.text :desc
      t.string :block_nature
      t.string :code_example_lang
      t.integer :demo_example_id
      t.string :demo_example_type

      t.timestamps null: false
    end
  end
end
