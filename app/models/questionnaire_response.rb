class QuestionnaireResponse < ActiveRecord::Base
  has_many :anonymous_responses
  accepts_nested_attributes_for :anonymous_responses
end
