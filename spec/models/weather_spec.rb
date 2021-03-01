require 'rails_helper'

RSpec.describe Weather, type: :model do
  before do
    place = Place.create(code:"1850147",name:"東京都東京")
    @weather = Weather.new(place.code)
  end
  describe '天気予報結果のテスト' do
    it '該当の地域が存在すればtrueを返す' do
        expect(@weather.return_info).to be >= 1
    end
    it '該当の地域がないとfalseを返す' do
        @weather = Weather.new("1")
        expect(@weather.return_info).to eq false
    end
  end
end
