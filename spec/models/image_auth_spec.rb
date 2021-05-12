require 'rails_helper'

RSpec.describe ImageAuth, type: :model do
  before do
    @num = 0
    @imageauth = ImageAuth.new(@num)
  end
  describe 'ランダム画像表示テスト' do
    it '期待通りに結果がでる1' do
      expect(@imageauth.auth_dis).to eq "sec0.gif"
      expect(@imageauth.auth_dis_word).to eq "4554"
      @imageauth = ImageAuth.new(@num += 1)
      expect(@imageauth.auth_dis).to eq "sec1.gif"
      expect(@imageauth.auth_dis_word).to eq "2209"
      @imageauth = ImageAuth.new(@num += 1)
      expect(@imageauth.auth_dis).to eq "sec2.gif"
      expect(@imageauth.auth_dis_word).to eq "3981"
    end
  end
end

