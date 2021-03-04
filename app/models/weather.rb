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
      day_today =  "2021-03-04"
      day_hour =  now_datetime.hour
      #day_hour =  "17"
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
        #icon = weather_items.icon.to_s
        #if hour == "12"
        if (hour == "12"  and (w_day > day_today or (day_hour.to_i < 11 and w_day == day_today ))) or (day_hour.to_i >= 11 and day_hour.to_i <17 and w_day == day_today and hour == "18") or (day_hour.to_i >= 17 and day_hour.to_i <21 and w_day == day_today and hour == "21")
          weather_data.push([day+hour_ja,w_name_ja,icon_url,w_get,w_name_ja])
        end
      end
      @return_info = true #"icon": "02d"
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
