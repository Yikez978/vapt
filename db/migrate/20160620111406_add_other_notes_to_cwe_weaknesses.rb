class AddOtherNotesToCweWeaknesses < ActiveRecord::Migration
  def change
  	add_column :cwe_weaknesses, :other_notes, :text
  end
end
