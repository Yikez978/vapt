class CreateCweModeOfIntros < ActiveRecord::Migration
  def change
    create_table :cwe_mode_of_intros do |t|
      t.text :mode_of_intro
      t.integer :mode_introable_id
      t.string :mode_introable_type

      t.timestamps null: false
    end
  end
end
