class Category < ApplicationRecord
  has_many :post
  mount_uploader :image, ImageUploader
  validates :name, presence: true, uniqueness: true
end
