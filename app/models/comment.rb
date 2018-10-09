class Comment < ApplicationRecord
  belongs_to :post #postモデルに紐づけ
  validates :body, presence: true #body必須項目
end
