class RemoveAnonymousQuestionsAndResponses < ActiveRecord::Migration
  def change
    drop_table :anonymous_responses
    drop_table :anonymous_questions
  end
end
