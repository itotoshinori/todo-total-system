class Weather < Weatheritem
  require "json"
  require "open-uri"
  require 'date'
  API_KEY = "333035987f1db09cade4bb868e15d88a"
  BASE_URL = "http://api.openweathermap.org/data/2.5/forecast"
  
  def initialize(placecode)
    begin
      id = placecode
      response = open(BASE_URL + "?id=#{id}&units=metric&APPID=#{API_KEY}")
      w_hash = JSON.load(response)
      now_datetime = DateTime.now
      day_today =  now_datetime.strftime("%Y-%m-%d")
      day_nextday  = (Date.today+1).strftime("%Y-%m-%d")
      day_hour =  now_datetime.hour
      day_hour =  "15"
      weather_data = []
      (0..31).each do |i|
        w_day = w_hash["list"][i]["dt_txt"].slice(0..9)
        month = w_hash["list"][i]["dt_txt"].slice(5..6) + "月"
        day = w_hash["list"][i]["dt_txt"].slice(8..9) + "日"
        hour = w_hash["list"][i]["dt_txt"].slice(11..12)
        hour_ja = hour + "時"
        w_name_en = w_hash["list"][i]["weather"][0]["description"]
        icon = w_hash["list"][i]["weather"][0]["icon"]
        weather_items = Weatheritem.new(w_name_en)
        w_name_ja = weather_items.ja_name.to_s
        if w_name_ja == "情報取得失敗"
          w_name_ja = w_name_en
          w_get = false
        else
          w_get = true
        end
        icon_url = "http://openweathermap.org/img/wn/#{icon}@2x.png"
        icon = weather_items.icon
        icon_url = "http://openweathermap.org/img/wn/#{icon}"
        if w_day == day_today
          if (day_hour.to_i <=6 and hour == "09") or (day_hour.to_i <=12 and hour == "15") or (day_hour.to_i >12 and day_hour.to_i <=15 and hour == "18") or (day_hour.to_i >=15 and day_hour.to_i < 21 and hour == "21")
            result = true
          end
        elsif  w_day == day_nextday 
          if (day_hour.to_i < 21 and hour == "12") or (day_hour.to_i >=21 and (hour == "09" or hour == "15"))
            result = true
          end
        elsif w_day > day_nextday and hour == "12"
          result = true
        else
          result = false
        end
        weather_data.push([day+hour_ja,w_name_ja,icon_url,w_get,w_name_ja]) if result
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

