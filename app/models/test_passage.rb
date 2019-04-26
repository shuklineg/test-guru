class TestPassage < ApplicationRecord
  MINIMUM_PERCENT = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validaton_set_first_question, on: :create
  before_update :before_update_next_question

  def correct_percentage
    correct_questions.to_f / test.questions.count * 100
  end

  def completed?
    current_question.nil?
  end

  def passed?
    correct_percentage >= MINIMUM_PERCENT
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)

    save!
  end

  def question_number
    test.questions.order(:id).where('id <= ?', current_question.id).count
  end

  private

  def before_validaton_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def before_update_next_question
    self.current_question = next_question
  end
end
