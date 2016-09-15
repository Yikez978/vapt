class CreateAnonymousQuestions < ActiveRecord::Migration
  def change
    create_table :anonymous_questions do |t|
      t.string :question
      t.boolean :active

      t.timestamps null: false
    end
  end
end
