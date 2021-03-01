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
      hour = Time.now.hour.to_i
      hour =22
      if hour <= 9
        day = Date.today
        start_time = 0
      elsif hour <= 15
        day = Date.today
        start_time = 1
      else
        day = Date.today + 1
        start_time = 0
      end
      last_time = 2
      daylist = []
      (start_time..last_time).each do |d|
        daylist.push(day.to_s + " 09:00:00")
        daylist.push(day.to_s + " 15:00:00") 
        daylist.push(day.to_s + " 21:00:00")  
        day = day + 1
      end
      id = placecode.to_s
      response = open(BASE_URL + "?id=#{id}&APPID=#{API_KEY}")
      wether_hash = JSON.load(response)
      @information = wether_hash
      weatherdate = []
      count = start_time
      wh = 0
      (start_time..7).each do |i|
        if wether_hash["list"][wh]["dt_txt"] == daylist[count]
          month = wether_hash["list"][wh]["dt_txt"].slice(5..6) + "月"
          day = wether_hash["list"][wh]["dt_txt"].slice(8..9) + "日"
          hour = wether_hash["list"][wh]["dt_txt"].slice(11..12) + "時"
          w_list = wether_hash["list"][wh]["weather"][0]["description"]
          date_hour =  day + hour 
          weatherdate << Weathercolletion.new(date_hour,weather_items[w_list]["ja"],weather_items[w_list]["icon"]) 
          count += 1
        end
        wh += 1
      end
      @return_info = count
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