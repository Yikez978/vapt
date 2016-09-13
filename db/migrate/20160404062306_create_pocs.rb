class CreatePocs < ActiveRecord::Migration
  def change
    create_table :pocs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
