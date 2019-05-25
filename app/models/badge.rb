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
  add_rule :first_try

  validates :level, presence: true, if: :has_level?
  validates :level,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            if: :has_level?

  validates :test, presence: true, if: :has_test?
  validates :category, presence: true, if: :has_category?

  def self.reward!(test_passage)
    all.each { |badge| badge.reward!(test_passage) }
  end

  private

  def complite_test(test_passage) end

  def complite_any_test(test_passage); end

  def complite_category(test_passage); end

  def complite_level(test_passage); end

  def first_try_test(test_passage); end

  def first_try(test_passage); end
end
