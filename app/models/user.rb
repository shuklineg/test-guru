class User < ApplicationRecord
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_many :passed_tests, dependent: :destroy
  has_many :own_tests, class_name: 'Test', foreign_key: :author_id, dependent: :nullify

  validates :encrypted_password, presence: true
  validates :email, format: VALID_EMAIL

  def tests_by_level(level)
    Test.joins(:passed_tests)
        .where(passed_tests: { user: self }, level: level)
        .distinct
  end
end
