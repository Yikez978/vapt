class CreateCwePrevEntryNames < ActiveRecord::Migration
  def change
    create_table :cwe_prev_entry_names do |t|
      t.date :name_change_date
      t.string :value
      t.integer :cwe_content_history_id

      t.timestamps null: false
    end
  end
end
