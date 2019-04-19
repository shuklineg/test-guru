class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy

  validates :test, presence: true
  validates_size_of :answers, minimum: 1, maximum: 4
end
