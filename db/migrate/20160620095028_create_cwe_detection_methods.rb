class CreateCweDetectionMethods < ActiveRecord::Migration
  def change
    create_table :cwe_detection_methods do |t|
      t.string :method_name
      t.text :method_desc
      t.string :method_effectiveness
      t.integer :detectable_id
      t.string :detectable_type

      t.timestamps null: false
    end
  end
end
