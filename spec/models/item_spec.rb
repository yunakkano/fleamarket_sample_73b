require 'rails_helper'
describe Item do
  describe '#create' do
  
    # presence: true 
    it "is valid with a name, price, introduction, item_condition_id, postage_payer_id, prefecture_code, preparation_day_id, postage_type_id, category_id" do
      category = create(:category)
      item = build(:item, category_id: category.id)
      expect(item).to be_valid
    end

    it "is invalid without name" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "is invalid without price" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end
  
    it "is invalid without introduction" do
      item = build(:item, introduction: "")
      item.valid?
      expect(item.errors[:introduction]).to include("を入力してください")
    end

    it "is invalid without item_condition_id" do
      item = build(:item, item_condition_id: "")
      item.valid?
      expect(item.errors[:item_condition_id]).to include("を選択してください")
    end

    it "is invalid without postage_payer_id" do
      item = build(:item, postage_payer_id: "")
      item.valid?
      expect(item.errors[:postage_payer_id]).to include("を選択してください")
    end

    it "is invalid without prefecture_code" do
      item = build(:item, prefecture_code: "")
      item.valid?
      expect(item.errors[:prefecture_code]).to include("を選択してください")
    end
   
    it "is invalid without preparation_day_id" do
      item = build(:item, preparation_day_id: "")
      item.valid?
      expect(item.errors[:preparation_day_id]).to include("を選択してください")
    end  

    it "is invalid without postage_type_id" do
      item = build(:item, postage_type_id: "")
      item.valid?
      expect(item.errors[:postage_type_id]).to include("を選択してください")
    end  

    it "is invalid without category_id" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category_id]).to include("を選択してください")
    end 

    
    # max length
    it "is invalid with a name that has more than 41 characters " do
      item = build(:item, name: "a" * 41)
      item.valid?
      expect(item.errors[:name]).to include("商品名は40字以内で書いてください")
    end

    it "is invalid with a introduction that has more than 1001 characters " do
      item = build(:item, introduction: "a" * 1001)
      item.valid?
      expect(item.errors[:introduction]).to include("商品紹介は1000文字以内で書いてください")
    end

    it "is valid with a name that has less than 40 characters " do
      item = build(:item, name: "a" * 40)
      expect(item).to be_valid
    end

    it "is valid with a introduction that has less than 1000 characters " do
      item = build(:item, introduction: "a" * 1000)
      expect(item).to be_valid
    end

    it "is invalid without a image" do
      item_no_picture = build(:item_no_picture)
      item_no_picture.valid?
      expect(item_no_picture.errors[:item_img]).to include()
    end
  end
end