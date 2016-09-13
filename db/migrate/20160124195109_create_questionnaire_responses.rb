class CreateQuestionnaireResponses < ActiveRecord::Migration
  def change
    create_table :questionnaire_responses do |t|

      t.timestamps null: false
    end
  end
end
