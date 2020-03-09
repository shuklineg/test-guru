class BadgeRule < ApplicationRecord
  RULE_TYPES = {
    test: %i[first_try test],
    category: %i[category],
    level: %i[level category]
  }.freeze

  belongs_to :badge
  belongs_to :category, optional: true
  belongs_to :test, optional: true

  scope :by_test, ->(test) { where(rule_type: 'test', test: [test, nil]) }
  scope :by_category, ->(category) { where(rule_type: 'category', category: [category, nil]) }
  scope :by_level, ->(level, category) { where(rule_type: 'level', level: level, category: [category, nil]) }

  validates :rule_type, presence: true
  validates :rule_type, inclusion: { in: RULE_TYPES.keys.map(&:to_s) }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :level_rule?

  def self.reward!(test_passage)
    by_test(test_passage.test).each { |rule| rule.reward!(test_passage) }
    by_category(test_passage.category).each { |rule| rule.reward!(test_passage) }
    by_level(test_passage.test.level, test_passage.category).each { |rule| rule.reward!(test_passage) }
  end

  def reward!(test_passage)
    @user = test_passage.user
    return if unique && @user.badges.include?(badge)

    @test = test_passage.test
    @category = test_passage.category
    @test_passage = test_passage
    award = @test_passage.passed? ? send("#{rule_type}_rule") : false
    @user.badges << badge if award
  end

  def params
    RULE_TYPES[rule_type.to_sym] || []
  end

  private

  def test_rule
    first_try ? @user.test_passages.where(test: @test).count == 1 : true
  end

  def category_rule
    @test_passage.category.complete?(@user)
  end

  def level_rule
    tests = category ? category.tests : Test
    byebug
    @user.tests_by_level(level, category).ids.sort.uniq == tests.where(level: level).ids
  end

  def level_rule?
    rule_type == 'level'
  end
end
