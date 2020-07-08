require 'rails_helper'
describe User do
  describe '#create' do
    it "first_name, family_name, first_name_kana, family_name_kana birthdayが存在すれば登録できること" do
        profile = build(:profile)
        expect(profile).to be_valid
    end
    it "first_nameがない場合は登録できないこと" do
        profile = build(:profile, first_name: "")
        profile.valid?
        expect(profile.errors[:first_name]).to include("can't be blank")
    end
    it "family_nameがない場合は登録できないこと" do
        profile = build(:profile, family_name: "")
        profile.valid?
        expect(profile.errors[:family_name]).to include("can't be blank")
    end
    it "first_name_kanaがない場合は登録できないこと" do
        profile = build(:profile, first_name_kana: "")
        profile.valid?
        expect(profile.errors[:first_name_kana]).to include("can't be blank")
    end
    it "family_name_kanaがない場合は登録できないこと" do
        profile = build(:profile, family_name_kana: "")
        profile.valid?
        expect(profile.errors[:family_name_kana]).to include("can't be blank")
    end
    it "birthdayがない場合は登録できないこと" do
        profile = build(:profile, birthday: "")
        profile.valid?
        expect(profile.errors[:birthday]).to include("can't be blank")
    end
    it "first_nameが存在しても全角でない場合登録できない" do
        profile = build(:profile, first_name: "test")
        profile.valid?
        expect(profile.errors[:first_name]).to include("名前は全角で入力してください。")
    end
    it "family_nameが存在しても全角でない場合登録できない" do
        profile = build(:profile, family_name: "test")
        profile.valid?
        expect(profile.errors[:family_name]).to include("名前は全角で入力してください。")
    end
    it "first_name_kanaが存在してもひらがなでない場合登録できない" do
        profile = build(:profile, first_name_kana: "test")
        profile.valid?
        expect(profile.errors[:first_name_kana]).to include("ひらがなで入力してください。")
    end
    it "family_name_kanaが存在してもひらがなでない場合登録できない" do
        profile = build(:profile, family_name_kana: "test")
        profile.valid?
        expect(profile.errors[:family_name_kana]).to include("ひらがなで入力してください。")
    end
    it "birthdayが存在しても日付が本日より先の場合は場合登録できないこと" do
        profile = build(:profile, birthday: Date.today+1)
        profile.valid?
        expect(profile.errors[:birthday]).to include("birthday must be before today")
    end
  end
end