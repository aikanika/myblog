class User < ActiveRecord::Base
  before_save   :downcase_mail
  before_create :create_activation_digest
  # userの新規登録時にpasswordを必須入力
  # passwordとpassword_confirmationが合致すること
  has_secure_password validations: true
  mount_uploader :image, ImageUploader
  # メールアドレスを必須入力かつユニークにする
  validates :mail, presence: true, uniqueness: true
  attr_accessor :remember_token, :activation_token, :reset_token

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # 永続的セッションで使用するユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # ユーザーログインを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

    # アカウントを有効にする
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

private

  # メールアドレスをすべて小文字にする
  def downcase_mail
    self.mail = mail.downcase
  end

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
