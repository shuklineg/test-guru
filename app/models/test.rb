class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :questions, dependent: :destroy
  has_many :passed_tests, dependent: :destroy

  def self.titles_by_category(title)
    joins(:category).where(categories: { title: title })
                    .order(title: :desc)
                    .pluck(:title)
  end
end
