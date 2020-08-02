require 'rails_helper'
describe User do
  describe '#create' do
    it "nickname, email, pass, pass confirmationが存在すれば登録できること" do
        user = build(:user)
        expect(user).to be_valid
    end
    it "nicknameがない場合は登録できないこと" do
        user = build(:user, nickname: "")
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
    end
    it "emailがない場合は登録できないこと" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
    end
    it "passwordがない場合は登録できないこと" do
        user = build(:user, password:"")
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
    end
    it "passwrodが存在してもpassword confirmationがない場合登録できないこと" do
        user = build(:user, password: "00000000", password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("を入力してください")
    end
    it "重複したemailは登録できないこと" do
        user = create(:user)
        another_user = build(:user)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
    end
    it "passwrodは最低7文字以上である場合登録できること" do
        user = build(:user, password: "1234567", password_confirmation: "1234567")
        expect(user).to be_valid
    end
    it "passwrodは最低6文字以下である場合登録できないこと" do
        user = build(:user, password: "123456")
        user.valid?
        expect(user.errors[:password]).to include("は最低7文字以上必要です")
    end
  end
end