class RemoveCweWeaknessIdFromCweAlternateTerms < ActiveRecord::Migration
  def change
  	remove_column :cwe_alternate_terms, :cwe_weakness_id

  	add_column :cwe_alternate_terms, :alternate_termable_id, :integer
  	add_column :cwe_alternate_terms, :alternate_termable_type, :string
  end
end
