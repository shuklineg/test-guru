class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :answers, through: :questions

  def self.titles_by_category(title)
    joins(:category).where(categories: { title: title })
                    .order(title: :desc)
                    .pluck(:title)
  end
end
