class CreateCweObservedExamples < ActiveRecord::Migration
  def change
    create_table :cwe_observed_examples do |t|
      t.string :observed_example_ref
      t.text :desc
      t.integer :observable_id
      t.string :observable_type

      t.timestamps null: false
    end
  end
end
