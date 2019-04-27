class TestPassage < ApplicationRecord
  MINIMUM_PERCENT = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_create :set_first_question
  before_update :set_next_question

  def correct_percentage
    correct_questions.to_f / test.questions.active.count * 100
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
    test.questions.active.order(:id).where('questions.id <= ?', current_question
  end

  private

  def set_first_question
    self.current_question = test.questions.active.first
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.active.order(:id).where('questions.id > ?', current_question.id).first
  end

  def set_next_question
    self.current_question = next_question
  end
end
