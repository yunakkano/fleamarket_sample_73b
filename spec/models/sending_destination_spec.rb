require 'rails_helper'
describe SendingDestination do
  describe '#create' do
    it "dest_first_name, dest_family_name, dest_first_name_kana, dest_family_name_kana, city, post_code, prefecture_code, street_number が存在すれば登録できること" do
        sending_destination = build(:sending_destination)
        expect(sending_destination).to be_valid
    end
    it "dest_first_nameがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, dest_first_name: "")
        sending_destination.valid?
        expect(sending_destination.errors[:dest_first_name]).to include("を入力してください")
    end
    it "dest_family_nameがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, dest_family_name: "")
        sending_destination.valid?
        expect(sending_destination.errors[:dest_family_name]).to include("を入力してください")
    end
    it "dest_first_name_kanaがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, dest_first_name_kana: "")
        sending_destination.valid?
        expect(sending_destination.errors[:dest_first_name_kana]).to include("を入力してください")
    end
    it "dest_family_name_kanaがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, dest_family_name_kana: "")
        sending_destination.valid?
        expect(sending_destination.errors[:dest_family_name_kana]).to include("を入力してください")
    end
    it "cityがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, city: "")
        sending_destination.valid?
        expect(sending_destination.errors[:city]).to include("を入力してください")
    end
    it "post_codeがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, post_code: "")
        sending_destination.valid?
        expect(sending_destination.errors[:post_code]).to include("を入力してください")
    end
    it "prefecture_codeがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, prefecture_code: "")
        sending_destination.valid?
        expect(sending_destination.errors[:prefecture_code]).to include("を入力してください")
    end
    it "street_numberがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, street_number: "")
        sending_destination.valid?
        expect(sending_destination.errors[:street_number]).to include("を入力してください")
    end
    it "dest_first_nameが存在しても全角でない場合登録できない" do
        sending_destination = build(:sending_destination, dest_first_name: "test")
        sending_destination.valid?
        expect(sending_destination.errors[:dest_first_name]).to include("は全角で入力してください。")
    end
    it "dest_family_nameが存在しても全角でない場合登録できない" do
        sending_destination = build(:sending_destination, dest_family_name: "test")
        sending_destination.valid?
        expect(sending_destination.errors[:dest_family_name]).to include("は全角で入力してください。")
    end
    it "dest_first_name_kanaが存在してもひらがなでない場合登録できない" do
        sending_destination = build(:sending_destination, dest_first_name_kana: "test")
        sending_destination.valid?
        expect(sending_destination.errors[:dest_first_name_kana]).to include("はひらがなで入力してください。")
    end
    it "dest_family_name_kanaが存在してもひらがなでない場合登録できない" do
        sending_destination = build(:sending_destination, dest_family_name_kana: "test")
        sending_destination.valid?
        expect(sending_destination.errors[:dest_family_name_kana]).to include("はひらがなで入力してください。")
    end
    it "cityが存在しても全角でない場合登録できない" do
        sending_destination = build(:sending_destination, city: "test")
        sending_destination.valid?
        expect(sending_destination.errors[:city]).to include("は全角で入力してください。")
    end
    it "post_codeが存在してもハイフン無し7桁の数字でない場合登録できない" do
        sending_destination = build(:sending_destination, post_code: "３２０−３３３３")
        sending_destination.valid?
        expect(sending_destination.errors[:post_code]).to include("はハイフン無しで数字7桁を入力してください。")
    end
    it "phone_numberが存在してもハイフン無し11桁の数字でない場合登録できない" do
        sending_destination = build(:sending_destination, phone_number: "123456789012")
        sending_destination.valid?
        expect(sending_destination.errors[:phone_number]).to include("はハイフン無しで数字10桁又は数字11桁を入力してください。")
    end
  end
end