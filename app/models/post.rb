class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  # @post.commnets
  validates :title, presence: true , length:{minimum:3, message: 'Too short to post!'}
  validates :tags, presence: true
  validates :body, presence: true
  validates :category_id, presence: true

  # カテゴリIDによる絞り込み
  scope :get_by_category_id, ->(category_id, published = nil){
    published ? where(category_id: category_id).where(published: published) : where(category_id: category_id)
  }
end
