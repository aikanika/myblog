class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  # @post.commnets
  validates :title, presence: true , length:{minimum:3, message: 'Too short to post!'}
  validates :body, presence: true

  # カテゴリIDによる絞り込み
  scope :get_by_category_id, ->(category_id){
    where(category_id: category_id)
  }
end
