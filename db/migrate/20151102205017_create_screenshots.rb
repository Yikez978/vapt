class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.string :file
      t.integer :report_id
      t.string :vulnerability_id

      t.timestamps null: false
    end
  end
end
