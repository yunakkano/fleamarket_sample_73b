class SnsCredential < ApplicationRecord
  belongs_to :user, optional: true

  # 最初のFacebook登録時にはuser_idが保存されないが、
  # これはsns_credentialを保存するタイミングではuser_idが確定していないため。
  # この状態でsns_credentialを保存するためにSnsCredentialモデルには
  # belongs_to user, optional: trueというオプションを追加

  validates :provider, :uid, presence: true
  validates_uniqueness_of :uid
end
