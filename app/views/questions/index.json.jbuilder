json.array!(@questions) do |question|
  json.extract! question, :id, :question, :answer, :course_id
  json.url question_url(question, format: :json)
end
