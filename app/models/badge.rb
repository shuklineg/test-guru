class Badge < ApplicationRecord
  include BadgeRuler

  belongs_to :category, optional: true
  belongs_to :test, optional: true
  has_and_belongs_to_many :users

  validates :caption, presence: true
  validates :image, presence: true

  add_rule :complete_test, params: [:test]
  add_rule :complete_any_test
  add_rule :complete_category, params: [:category]
  add_rule :complete_level, params: [:level]
  add_rule :first_try_test, params: [:test]
  add_rule :first_try_any_test
  add_rule :complete_any_category

  validates :level, presence: true, if: :has_level?
  validates :level,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            if: :has_level?

  validates :test, presence: true, if: :has_test?
  validates :category, presence: true, if: :has_category?

  private

  def complete_test
    @test == test && complete_any_test
  end

  def complete_any_test
    @test_passage.passed?
  end

  def complete_category
    @test_passage.category == category && complete_any_category
  end

  def complete_any_category
    @test_passage.passed? && @test_passage.category.complete?(@user)
  end

  def complete_level
    @test_passage.passed? && @user.test_by_level(level).test_ids.sort.uniq == Test.where(level: level).ids
  end

  def first_try_test
    @test == test && first_try_any_test
  end

  def first_try_any_test
    @test_passage.passed? && @user.test_passages.where(test: @test_passage.test).count == 1
  end
end
