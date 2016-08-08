class CreateCweRelatedAttackPatterns < ActiveRecord::Migration
  def change
    create_table :cwe_related_attack_patterns do |t|
      t.string :capec_version
      t.string :capec_id
      t.integer :attackable_id
      t.string :attackable_type

      t.timestamps null: false
    end
  end
end
