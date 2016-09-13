class CreateCweTechnologyClasses < ActiveRecord::Migration
  def change
    create_table :cwe_technology_classes do |t|
      t.string :prevalence
      t.string :name
      t.integer :technology_classable_id
      t.string :technology_classable_type

      t.timestamps null: false
    end
  end
end
