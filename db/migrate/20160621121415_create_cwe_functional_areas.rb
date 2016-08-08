class CreateCweFunctionalAreas < ActiveRecord::Migration
  def change
    create_table :cwe_functional_areas do |t|
      t.string :functional_area
      t.integer :functionable_id
      t.string :functionable_type

      t.timestamps null: false
    end
  end
end
