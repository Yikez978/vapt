class CreateOcbs < ActiveRecord::Migration
  def change
    create_table :ocbs do |t|
      t.string :name
      t.string :number
      t.integer :engagement_id

      t.timestamps null: false
    end
  end
end
