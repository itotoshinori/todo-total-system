require 'rails_helper'

RSpec.describe Scrap_check, type: :model do
  before do
    @url = "http://titonet384.sakura.ne.jp/kokuho/"
    @scrap = Scrap_check.new
  end
  describe 'スク―ピングテスト' do
    it 'div内にいずれか指定の文字があればtrueを返す' do
      check = @scrap.check(@url,"ホーム","分類別","法隆寺")   
      expect(check).to eq true
    end
    it 'div内にいずれか指定の文字がなければfalseを返す' do
        check = @scrap.check(@url,"テスト","テスト","テスト")  
        expect(check).to eq false
    end
  end
end