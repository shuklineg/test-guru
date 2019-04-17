class User < ApplicationRecord
  def tests(level)
    Test.joins(:answers)
        .where(answers: { user_id: id }, tests: { level: level })
        .distinct
  end
end
