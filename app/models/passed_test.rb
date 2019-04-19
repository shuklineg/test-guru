class PassedTest < ApplicationRecord
  belongs_to :user
  belongs_to :test

  validates :user, :test, presence: true
end
