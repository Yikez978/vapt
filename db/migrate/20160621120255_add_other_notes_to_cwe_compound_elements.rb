class AddOtherNotesToCweCompoundElements < ActiveRecord::Migration
  def change
  	add_column :cwe_compound_elements, :other_notes, :text
  end
end
