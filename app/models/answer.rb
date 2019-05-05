class Answer < ApplicationRecord
  MAXIMUM_ANSWES = 4

  belongs_to :question

  scope :correct, -> { where(correct: true) }

  validates :body, presence: true
  validate :validate_count

  private

  def validate_count
    maximum = question && question.answers.size > MAXIMUM_ANSWES
    errors.add(:count, I18n.t('.too_much', count: MAXIMUM_ANSWES)) if maximum
  end
end
