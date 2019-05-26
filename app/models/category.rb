class Category < ApplicationRecord
  has_many :tests, dependent: :destroy
  has_many :test_passages, through: :tests
  default_scope -> { order(title: :asc) }

  validates :title, presence: true
  validates :title, uniqueness: true

  def passed?(user)
    true if test_passages.where(user: user).select(&:passed?).map(&:test_id).sort.uniq == test_ids
  end
end
