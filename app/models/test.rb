class Test < ApplicationRecord
  belongs_to :category

  def self.category(title)
    Test.select('categories.title')
        .joins('JOIN categories ON categories.id = tests.category_id')
        .where('categories.title = ?', title)
        .order(:desc)
  end
end
