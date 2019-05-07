module QuestionsHelper
  def question_header(question)
    action = question.new_record? ? t('.create') : t('.edit')
    t('.question_title', action: action, test: question.test&.title)
  end
end
