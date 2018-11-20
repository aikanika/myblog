class User < ActiveRecord::Base
  # userの新規登録時にpasswordを必須入力
  # passwordとpassword_confirmationが合致すること
  has_secure_password validations: true
  mount_uploader :image, ImageUploader
  # メールアドレスを必須入力かつユニークにする
  validates :mail, presence: true, uniqueness: true


  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
end
