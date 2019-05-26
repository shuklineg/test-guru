class Badge < ApplicationRecord
  include BadgeRuler

  belongs_to :category, optional: true
  belongs_to :test, optional: true
  has_and_belongs_to_many :users

  validates :caption, presence: true
  validates :image, presence: true

  add_rule :complite_test, params: [:test]
  add_rule :complite_any_test
  add_rule :complite_category, params: [:category]
  add_rule :complite_level, params: [:level]
  add_rule :first_try_test, params: [:test]
  add_rule :first_try_any_test

  validates :level, presence: true, if: :has_level?
  validates :level,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            if: :has_level?

  validates :test, presence: true, if: :has_test?
  validates :category, presence: true, if: :has_category?

  private

  def complite_test
    true if @test_passage.passed? && @test == test
  end

  def complite_any_test
    true if @test_passage.passed?
  end

  def complite_category
    return false if @test.category != category

    @test_passage.passed? && category.passed?(@user)
  end

  def complite_level
    @test_passage.passed? && @user.test_by_level(level).test_ids.sort.uniq == Test.where(level: level).ids
  end

  def first_try_test
    return false if @test != test

    @test_passage.passed? && @user.test_passages.where(test_id: @test_passage.test.id).count == 1
  end

  def first_try_any_test
    @test_passage.passed? && @user.test_passages.where(test_id: @test_passage.test.id).count == 1
  end
end
