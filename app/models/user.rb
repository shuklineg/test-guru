class User < ApplicationRecord
  def tests(level)
    Test.joins('JOIN questions ON questions.test_id = tests.id')
        .joins('JOIN answers ON answers.question_id = questions.id')
        .where(
          'answers.user_id = :id AND tests.level = :level',
          id: id,
          level: level
        )
  end
end
