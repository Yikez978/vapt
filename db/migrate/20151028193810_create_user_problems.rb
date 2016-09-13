class CreateUserProblems < ActiveRecord::Migration
  def change
    create_table :user_problems do |t|
      t.integer :user_id
      t.integer :problem_id
      t.text :explanation

      t.timestamps null: false
    end
  end
end
