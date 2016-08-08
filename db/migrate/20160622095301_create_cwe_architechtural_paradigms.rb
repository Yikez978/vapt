class CreateCweArchitechturalParadigms < ActiveRecord::Migration
  def change
    create_table :cwe_architechtural_paradigms do |t|
      t.string :prevalence
      t.string :name
      t.integer :paradigmable_id
      t.string :paradigmable_type

      t.timestamps null: false
    end
  end
end
