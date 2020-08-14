require 'rails_helper'

RSpec.describe SnsCredential do
  describe  '#create' do
    it 'uidに重複がなければ、user_idが空でもsns_credentialが登録できること', :oauth do
      user = build(:user)
      sns_credential = build(:sns_credential)
      sns_credential.valid?
      expect(sns_credential).to be_valid
    end

    it 'uidが空場合にはsns_credentialが登録できないこと', :oauth do
      sns_credential = build(:sns_credential, uid: "")
      sns_credential.valid?
      expect(sns_credential.errors[:uid]).to include("が取得できませんでした")
    end

    it 'uidに重複が重複している場合には、providerが違っていてもsns_credentialが登録できないこと', :oauth do
      sns_credential = create(:sns_credential) 
      another_credential = build(:sns_credential, uid: '12345', provider: 'google_oauth2')
      another_credential.valid?
      expect(another_credential.errors[:uid]).to include("はすでに登録されています")
    end

  end
end