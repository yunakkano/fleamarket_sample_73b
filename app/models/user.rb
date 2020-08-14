class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2], password_length: 7..128
  has_one :profile, dependent: :destroy
  has_one :sending_destination, dependent: :destroy
  has_one :card, dependent: :destroy
  has_one :self_introduction, dependent: :destroy
  has_many :seller_items, foreign_key: "seller_id", class_name: "items"
  has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"
  has_many :favorites, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item
  has_many :sns_credentials, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :nickname, presence: true

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    if sns.user
      user = sns.user
    else
      user = User.where(email: auth.info.email).first_or_initialize(
        nickname: auth.info.name,
        email: auth.info.email
      )
      profile = Profile.where(user_id: user.id).first_or_initialize(
        first_name: auth.info.first_name,
        family_name: auth.info.last_name
      )
    end
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns, profile: profile }
  end
end