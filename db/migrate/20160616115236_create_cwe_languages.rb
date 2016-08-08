class CreateCweLanguages < ActiveRecord::Migration
  def change
    create_table :cwe_languages do |t|
      t.string :language_name
      t.string :language_class
      t.integer :language_id
      t.string :language_type

      t.timestamps null: false
    end
  end
end
