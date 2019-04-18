class User < ApplicationRecord
  has_many :passed_tests

  def tests_by_level(level)
    Test.joins(:passed_tests)
        .where(passed_tests: { user: self }, level: level)
        .distinct
  end
end
