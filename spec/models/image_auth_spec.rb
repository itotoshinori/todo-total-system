require 'rails_helper'

RSpec.describe ImageAuth, type: :model do
  before do
    @num = 1
    @imageauth = ImageAuth.new(@num)
  end
  describe 'ランダム画像表示テスト' do
    it '期待通りに結果がでる1' do
      @num = 1
      expect(@imageauth.auth_dis).to eq "l2.jpg"
    end
    it '期待通りに結果がでる2' do
      expect(@imageauth.auth_dis_word).to eq "3kR23*$2"
    end
    it '期待通りに結果がでる4' do
      @imageauth = ImageAuth.new(3)
      expect(@imageauth.auth_dis).to eq "l4.gif"
      expect(@imageauth.auth_dis_word).to eq "+LasW#3$2"
    end
    it '期待通りに結果がでる5' do
      @imageauth = ImageAuth.new(4)
      expect(@imageauth.auth_dis).to eq "l5.gif"
      expect(@imageauth.auth_dis_word).to eq "+95lJKJ?"
    end
    it '期待通りに結果がでる6' do
      @imageauth = ImageAuth.new(5)
      expect(@imageauth.auth_dis).to eq "l6.gif"
      expect(@imageauth.auth_dis_word).to eq "&YnNa$MkV"
    end
  end
end

