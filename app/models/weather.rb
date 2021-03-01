class Weather
  require "json"
  require "open-uri"
  require 'date'
  require 'weatheritems'
  API_KEY = "333035987f1db09cade4bb868e15d88a"
  BASE_URL = "http://api.openweathermap.org/data/2.5/forecast"
  
  def initialize(placecode)
    begin
      weather_items = Weatheritems.new.items
      id = placecode
      response = open(BASE_URL + "?id=#{id}&APPID=#{API_KEY}")
      hash = JSON.load(response)
      t = DateTime.now + Rational(10, 24)
      day_today =  t.strftime("%Y-%m-%d")  
      current_hour = t.hour
      wh = 0
      weatherdate = []
      (7..13).each do |i|
        suu = hash["list"][wh]["dt_txt"].slice(0..9)
        month = hash["list"][wh]["dt_txt"].slice(5..6) + "月"
        day = hash["list"][wh]["dt_txt"].slice(8..9) + "日"
        hour = hash["list"][wh]["dt_txt"].slice(11..12)
        hour_dis = hour + "時"
        w_list = hash["list"][wh]["weather"][0]["description"]
        date_hour = day + hour_dis 
      if  (suu.to_s == day_today.to_s and hour.to_i > current_hour.to_i) or suu.to_s > day_today.to_s
        weatherdate.push([date_hour,weather_items[w_list]["ja"],weather_items[w_list]["icon"]]) 
      end
      wh += 1
    end
      @return_info = current_hour.to_s+"時"+day_today
      @information = weatherdate
    rescue => exception
      @information = false
      @return_info = false
    end
  end
  def re_info
    @information
  end

  def return_info
    @return_info
  end
end

class Weathercolletion
  attr_accessor :datehour,:date,:icon
  def initialize(datehour,date,icon)
    self.datehour = datehour
    self.date = date
    self.icon = icon
  end
end