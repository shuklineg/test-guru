class Badge < ApplicationRecord
  has_and_belongs_to_many :users
  has_one :rule, class_name: 'BadgeRule', dependent: :nullify

  validates :caption, presence: true
  validates :image, presence: true

  def self.images
    Dir.glob('app/assets/images/badges/*').map { |image| [File.basename(image), image.gsub('app/assets/images/', '')] }
  end
end
