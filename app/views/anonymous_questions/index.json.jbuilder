json.array!(@anonymous_questions) do |anonymous_question|
  json.extract! anonymous_question, :id, :string, :active
  json.url anonymous_question_url(anonymous_question, format: :json)
end
