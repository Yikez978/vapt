class CreateCweMitigations < ActiveRecord::Migration
  def change
    create_table :cwe_mitigations do |t|
      t.string :mitigation_id
      t.string :mitigation_phase
      t.string :mitigation_strategy
      t.text :desc
      t.integer :mitigatable_id
      t.string :mitigatable_type

      t.timestamps null: false
    end
  end
end
