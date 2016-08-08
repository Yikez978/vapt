class CreateCweAlternateTerms < ActiveRecord::Migration
  def change
    create_table :cwe_alternate_terms do |t|
      t.string :term
      t.text :desc
      t.integer :cwe_weakness_id

      t.timestamps null: false
    end
  end
end
