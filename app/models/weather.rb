class Weather < Weatheritem
  require "json"
  require "open-uri"
  require 'date'
  require 'config'
  API_KEY = "38ccd939d777d6a1279227696ad2a4bf"
  BASE_URL = "http://api.openweathermap.org/data/2.5/forecast"
  
  def initialize(placecode)
    begin
      config = Config.new
      id = placecode
      response = open(BASE_URL + "?id=#{id}&units=metric&APPID=#{API_KEY}")
      w_hash = JSON.load(response)
      now_datetime = DateTime.now
      day_today =  now_datetime.strftime("%Y-%m-%d")
      day_nextday  = (Date.today+1).strftime("%Y-%m-%d")
      day_hour =  now_datetime.hour
      #day_hour =  21
      
      weather_data = []
      (0..31).each do |i|
        w_day = w_hash["list"][i]["dt_txt"].slice(0..9)
        month = w_hash["list"][i]["dt_txt"].slice(5..6) 
        day = w_hash["list"][i]["dt_txt"].slice(8..9) 
        hour = w_hash["list"][i]["dt_txt"].slice(11..12)
        temp = w_hash["list"][i]["main"]["temp_max"].round
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
        #icon_url = "http://openweathermap.org/img/wn/#{icon}@2x.png"
        if hour >= "19"
          end_word = "n@2x.png"
        else
          end_word = "d@2x.png"
        end
        icon = weather_items.icon
        icon_url = "http://openweathermap.org/img/wn/#{icon}#{end_word}"
        if w_day == day_today
          if (day_hour.to_i <=6 and hour == "09") or (day_hour.to_i <=12 and hour == "15") or (day_hour.to_i >12 and day_hour.to_i <=15 and hour == "18") or (day_hour.to_i >=12 and day_hour.to_i < 21 and hour == "21")
          #if  day_hour.to_i <= 9 and hour == "12" 
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
        dayhour = config.prezero_exclusion(day)+ "日" + config.prezero_exclusion(hour) + "時"
        weather_data.push([dayhour,w_name_ja,icon_url,w_get,temp.to_s]) if result
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
