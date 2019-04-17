class User < ApplicationRecord
  def tests(level)
    Test.joins(:answers)
        .where(answers: { user: self }, tests: { level: level })
        .distinct
  end
end
