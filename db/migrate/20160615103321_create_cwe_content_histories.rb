class CreateCweContentHistories < ActiveRecord::Migration
  def change
    create_table :cwe_content_histories do |t|
      t.integer :contentable_id
      t.string :contentable_type

      t.timestamps null: false
    end
  end
end
