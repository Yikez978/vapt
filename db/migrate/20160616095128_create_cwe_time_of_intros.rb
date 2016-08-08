class CreateCweTimeOfIntros < ActiveRecord::Migration
  def change
    create_table :cwe_time_of_intros do |t|
      t.text :intro_phase
      t.integer :cwe_category_id

      t.timestamps null: false
    end
  end
end
