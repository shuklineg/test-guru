class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  scope :by_level, ->(level) { where(level: level) }
  scope :easy, -> { by_level(0..1) }
  scope :normal, -> { by_level(2..4) }
  scope :hard, -> { by_level(5..Float::INFINITY) }
  scope :by_category, ->(title) { joins(:category).where(categories: { title: title }) } 

  validates :title, :level, presence: true
  validates :title, uniqueness: { scope: :level, case_sensitive: false }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.titles_by_category(title)
    by_category(title).pluck(:title)
  end

  def active?
    !questions.active.empty?
  end
end
