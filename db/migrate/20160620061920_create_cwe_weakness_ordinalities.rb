class CreateCweWeaknessOrdinalities < ActiveRecord::Migration
  def change
    create_table :cwe_weakness_ordinalities do |t|
      t.string :ordinality
      t.integer :ordinalable_id
      t.string :ordinalable_type

      t.timestamps null: false
    end
  end
end
