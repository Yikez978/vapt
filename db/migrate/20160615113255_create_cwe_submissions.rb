class CreateCweSubmissions < ActiveRecord::Migration
  def change
    create_table :cwe_submissions do |t|
      t.string :submission_source
      t.string :submitter

      t.timestamps null: false
    end
  end
end
