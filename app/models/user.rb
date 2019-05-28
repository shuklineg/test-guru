class User < ApplicationRecord
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  has_many :own_tests, class_name: 'Test', foreign_key: :author_id, dependent: :nullify
  has_many :gists
  has_many :feedbacks
  has_and_belongs_to_many :badges

  def tests_by_level(level, category = nil)
    result = tests.where(level: level)
    category ? result.where(category: category) : result
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def fullname
    I18n.t('user.fullname', first_name: first_name, last_name: last_name).strip
  end

  def admin?
    is_a?(Admin)
  end
end
