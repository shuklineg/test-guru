class BadgeRule < ApplicationRecord
  belongs_to :badge
  belongs_to :resource, polymorphic: true, optional: true

  RULE_TYPES = {
    test: { params: %i[first_try], resources: [Test, NilClass] },
    category: { params: [], resources: [Category, NilClass] },
    level: { params: %i[level], resources: [Category, NilClass] }
  }.freeze

  validates :rule_type, presence: true
  validates :rule_type, inclusion: { in: RULE_TYPES.keys.map(&:to_s) }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :level_rule?

  def self.by_test(test)
    where(resource: test)
      .or(where(resource: nil))
      .where(rule_type: 'test')
  end

  def self.by_category(category)
    where(resource: category)
      .or(where(resource: nil))
      .where(rule_type: 'category')
  end

  def self.by_level(level, category)
    where(resource: category)
      .or(where(resource: nil))
      .where(rule_type: 'level', level: level)
  end

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

  def options
    OpenStruct.new(RULE_TYPES[rule_type.to_sym])
  end

  private

  def test_rule
    first_try ? @user.test_passages.where(test: @test).count == 1 : true
  end

  def category_rule
    @test_passage.category.complete?(@user)
  end

  def level_rule
    tests = resource ? resource.tests : Test
    @user.test_by_level(level).test_ids.sort.uniq == tests.where(level: level).ids
  end

  def level_rule?
    rule_type == 'level'
  end
end
