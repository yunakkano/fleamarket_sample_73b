require 'rails_helper'

describe ItemsController, type: :controller do
  describe 'POST #pay' do
    it "@itemが期待される値を持つ" do
      post :pay, params: { id: 1 }
      expect(assigns(:item)).to eq item
    end
    it "@cardが期待される値を持つ" do
        post :pay, params: { user_id: 1 }
        expect(assigns(:card)).to eq card
    end
  end
end