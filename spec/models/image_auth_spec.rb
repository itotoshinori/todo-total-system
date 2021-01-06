require 'rails_helper'

RSpec.describe ImageAuth, type: :model do
  before do
    @num = 1
    @imageauth = ImageAuth.new(@num)
  end
  describe 'ランダム画像表示テスト' do
    it '期待通りに結果がでる1' do
      expect(@imageauth.auth_dis).to eq "l2.jpg"
    end
    it '期待通りに結果がでる2' do
      expect(@imageauth.auth_dis_word).to eq "3kR23*$2"
    end
  end
end

