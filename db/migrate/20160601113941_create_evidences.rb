class CreateEvidences < ActiveRecord::Migration
  def change
    create_table :evidences do |t|
      t.string :name
      t.string :rights
      t.string :size
      t.string :date
      t.string :type
      t.string :ancestry

      t.timestamps null: false
    end
  end
end
