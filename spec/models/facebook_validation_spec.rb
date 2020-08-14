require 'rails_helper'

RSpec.describe SnsCredential, type: :model do
  describe  '#facebook validation' do
    before do
      Rails.application.env_config['omniauth.auth'] = facebook_mock
    end
    context '認可サーバーから返ってきたメールアドレスを、すでに登録済みのuserが持っていた場合' do
      before do
        user = create(:user, email: 'sample@test.com')
      end
      context '認可サーバーから帰ってきた情報とprovider名が異なるが、同じuidを持つSnsCredentialレコードがあった場合' do
        before do
          SnsCredential.create(provider: 'google_oauth2', uid: '12345', user_id: '1')
        end
          example 'uidのvalidation(unique制約）が機能するか' do
            expect(SnsCredential.create(provider: 'facebook', uid: '12345', user_id: '1').errors[:uid]).to include('はすでに登録されています')
          end         
      end
    end
  end
end