class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :options, limit: 3116480 # number of letters in the KJV -- that's good enough in my book

      t.timestamps null: false
    end
  end
end
