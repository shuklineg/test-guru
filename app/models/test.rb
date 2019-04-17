class Test < ApplicationRecord
  belongs_to :category

  def self.category(title)
    select('title')
      .joins('JOIN categories ON categories.id = tests.category_id')
      .where('categories.title = ?', title)
      .order(:desc)
  end
end
