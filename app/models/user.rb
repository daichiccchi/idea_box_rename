class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save { email.downcase! }
  before_create :create_activation_digest
  # =before_save {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :user_area, presence: true, inclusion: { in: 1..47 }
  # validates :user_job, inclusion: { in: 1..8 }
  validates :school_year, presence: true
  has_secure_password
  validates :password, presence: true, length: {minimum: 6 } , allow_nil: true
  
  has_many :topics
  has_many :favorites
  has_many :comments
  has_many :submits
   has_many :submit_topics, through: :submits, source: 'topic'
  
   mount_uploader :avatar, AvatarUploader
  
    enum user_areas: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }
  
  enum user_jobs: {
    校長:1,教頭:2,主幹教諭:3,教諭:4,養護教諭:5,講師:6,学生:7,その他:8
  }
  
    enum school_years: {
    小１:1,小２:2,小３:3,小４:4,小５:5,小６:6,
    中１:7,中２:8,中３:9,
  }
  
  #渡された文字列のハッシュを返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  #ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  #永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
 # 渡されたトークンがダイジェストと一致したらtrueを返す
  # def authenticated?(remember_token)
  #   if remember_digest.nil?
  #     false
  #   else
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  #   end
  # end
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  #　ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # アカウントを有効にする
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end
  
  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  #パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end
  
  #パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  #パスワードの再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at > 2.hours.ago
  end
  
  private
  
  #メールアドレスをすべて小文字にする
  def downcase_eamil
    self.email.downcase!
  end
  
  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token   = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end