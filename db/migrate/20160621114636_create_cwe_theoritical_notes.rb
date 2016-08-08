class CreateCweTheoriticalNotes < ActiveRecord::Migration
  def change
    create_table :cwe_theoritical_notes do |t|
      t.text :note
      t.integer :theory_notable_id
      t.string :theory_notable_type

      t.timestamps null: false
    end
  end
end
