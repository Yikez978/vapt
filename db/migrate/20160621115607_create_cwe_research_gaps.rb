class CreateCweResearchGaps < ActiveRecord::Migration
  def change
    create_table :cwe_research_gaps do |t|
      t.text :research_gap
      t.integer :research_gapable_id
      t.string :research_gapable_type

      t.timestamps null: false
    end
  end
end
