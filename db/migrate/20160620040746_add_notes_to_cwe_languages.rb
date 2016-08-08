class AddNotesToCweLanguages < ActiveRecord::Migration
  def change
  	add_column :cwe_languages, :note, :text
  end
end
