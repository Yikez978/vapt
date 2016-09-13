class AnonymousResponse < ActiveRecord::Base
  belongs_to :anonymous_questionnaire
  has_one :anonymous_question
end
