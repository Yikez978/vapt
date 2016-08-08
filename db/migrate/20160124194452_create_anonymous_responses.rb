class CreateAnonymousResponses < ActiveRecord::Migration
  def change
    create_table :anonymous_responses do |t|
      t.integer :anonymous_question_id
      t.text :value

      t.timestamps null: false
    end
  end
end
