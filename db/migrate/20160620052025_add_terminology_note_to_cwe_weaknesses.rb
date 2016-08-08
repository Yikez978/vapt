class AddTerminologyNoteToCweWeaknesses < ActiveRecord::Migration
  def change
  	add_column :cwe_weaknesses, :terminology_note, :text
  	add_column :cwe_weaknesses, :liklihood_of_exploit, :string
  end
end
