class User < ApplicationRecord
  has_many :passed_tests, dependent: :destroy
  has_many :own_tests, class_name: 'Test', foreign_key: :author_id, dependent: :nullify

  def tests_by_level(level)
    Test.joins(:passed_tests)
        .where(passed_tests: { user: self }, level: level)
        .distinct
  end
end
