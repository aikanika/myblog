class Post < ApplicationRecord
  acts_as_taggable_on :tags
  acts_as_taggable
  has_many :comments, dependent: :destroy
  mount_uploaders :image, ImageUploader
  # @post.commnets
  validates :title, presence: true , length:{minimum:3, message: 'Too short to post!'}
  validates :body, presence: true
  validates :category_id, presence: true

  # カテゴリIDによる絞り込み
  scope :get_by_category_id, ->(category_id, published = nil){
    published ? where(category_id: category_id).where(published: published) : where(category_id: category_id)
  }


end
