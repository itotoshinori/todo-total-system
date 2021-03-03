class Weather
  require "json"
  require "open-uri"
  require 'date'
  require 'weatheritems'
  API_KEY = "333035987f1db09cade4bb868e15d88a"
  BASE_URL = "http://api.openweathermap.org/data/2.5/forecast"
  
  def initialize(placecode)
    begin
      id = placecode
      response = open(BASE_URL + "?id=#{id}&APPID=#{API_KEY}")
      w_hash = JSON.load(response)
      weather_data = []
      (4..32).each do |i|
        month = w_hash["list"][i]["dt_txt"].slice(5..6) + "月"
        day = w_hash["list"][i]["dt_txt"].slice(8..9) + "日"
        hour = w_hash["list"][i]["dt_txt"].slice(11..12)
        hour_ja = hour + "時"
        w_name_en = w_hash["list"][i]["weather"][0]["description"]
        weather_items = Weatheritems.new(w_name_en)
        w_name_ja = weather_items.ja_name.to_s
        if w_name_ja == "情報取得失敗"
          w_name_ja = w_name_en
          w_get = false
        else
          w_get = true
        end
        icon = weather_items.icon.to_s
        if hour == "12"
          weather_data.push([day+hour_ja,w_name_ja,icon,w_get],)
        end
      end
      @return_info = true
      @information = weather_data
    rescue => exception
      @return_info = false
      @information = false
    end
  end
  def return_info
    @return_info
  end
  def re_info
    @information
  end
end
