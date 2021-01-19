require 'rails_helper'

RSpec.describe ImageAuth, type: :model do
  before do
    @num = 0
    @imageauth = ImageAuth.new(@num)
  end
  describe 'ランダム画像表示テスト' do
    it '期待通りに結果がでる1' do
      expect(@imageauth.auth_dis).to eq "l1.jpg"
      expect(@imageauth.auth_dis_word).to eq "4l3hw@65!"
      @imageauth = ImageAuth.new(@num += 1)
      expect(@imageauth.auth_dis).to eq "l2.jpg"
      expect(@imageauth.auth_dis_word).to eq "3kR23*$2"
      @imageauth = ImageAuth.new(@num += 1)
      expect(@imageauth.auth_dis).to eq "l3.gif"
      expect(@imageauth.auth_dis_word).to eq "5*+75RtY&"
      @imageauth = ImageAuth.new(@num += 1)
      expect(@imageauth.auth_dis).to eq "l4.gif"
      expect(@imageauth.auth_dis_word).to eq "+LasW#3$2"
      @imageauth = ImageAuth.new(@num += 1)
      expect(@imageauth.auth_dis).to eq "l5.gif"
      expect(@imageauth.auth_dis_word).to eq "+95lJKJ?"
      @imageauth = ImageAuth.new(@num += 1)
      expect(@imageauth.auth_dis).to eq "l6.gif"
      expect(@imageauth.auth_dis_word).to eq "&YnNa$MkV"
    end
  end
end

