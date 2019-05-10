class Gist < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :gistid, presence: true
end
